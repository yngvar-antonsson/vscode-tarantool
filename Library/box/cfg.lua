---@meta
--luacheck: ignore

---@alias election_mode
---| 'candidate'
---| 'off'
---| 'voter'

---@alias log_level
---| 1 # SYSERROR
---| 2 # ERROR
---| 3 # CRITICAL
---| 4 # WARNING
---| 5 # INFO
---| 6 # VERBOSE
---| 7 # DEBUG

---@alias log
---| 'file: '
---| 'pipe: '
---| 'syslog:identity= '
---| 'syslog:facility= '
---| 'syslog:identity= ,facility= '
---| 'syslog:server= '

---@alias log_format
---| 'plain'
---| 'json'

---@alias wal_mode
---| 'none' # write-ahead log is not maintained. A node with wal_mode = none can’t be replication master
---| 'write' # fibers wait for their data to be written to the write-ahead log (no fsync(2))
---| 'fsync' # fibers wait for their data, fsync(2) follows each write(2)

---@class BoxCfg
---@field background boolean (default: false)
---@field checkpoint_count number (Default: 2) The maximum number of snapshots that may exist on the memtx_dir directory before the checkpoint daemon will delete old snapshots
---@field checkpoint_interval number (Default: 3600 (one hour)) The interval between actions by the checkpoint daemon, in seconds. If checkpoint_interval is set to a value greater than zero, and there is activity which causes change to a database, then the checkpoint daemon will call box.snapshot() every checkpoint_interval seconds, creating a new snapshot file each time. If checkpoint_interval is set to zero, then the checkpoint daemon is disabled
---@field checkpoint_wal_threshold number (Default: 10^18 (a large number so in effect there is no limit by default)) The threshold for the total size in bytes of all WAL files created since the last checkpoint
---@field coredump boolean (Default: false) DEPRECATED, DO NOT USE 
---@field custom_proc_title string (Default: nil) Add the given string to the server’s process title
---@field election_mode election_mode (Default: off) enables RAFT
---@field feedback_enabled boolean (Default: true) Whether to send feedback
---@field feedback_host string (Default: 'https://feedback.tarantool.io') The address to which the packet is sent. Usually the recipient is Tarantool, but it can be any URL
---@field feedback_interval number (Default: 3600) The number of seconds between sendings, usually 3600 (1 hour).
---@field force_recovery boolean (Default: false) If force_recovery equals true, Tarantool tries to continue if there is an error while reading a snapshot file (at server instance start) or a write-ahead log file (at server instance start or when applying an update at a replica): skips invalid records, reads as much data as possible and lets the process finish with a warning. Users can prevent the error from recurring by writing to the database and executing box.snapshot()
---@field hot_standby boolean (Default: false) Whether to start the server in hot standby mode. Hot standby is a feature which provides a simple form of failover without replication
---@field instance_uuid string (Generated automatically) For replication administration purposes, it is possible to set the universally unique identifiers of the instance (instance_uuid) and the replica set (replicaset_uuid), instead of having the system generate the values
---@field io_collect_interval number (Default: nil) The instance will sleep for io_collect_interval seconds between iterations of the event loop. Can be used to reduce CPU load in deployments in which the number of client connections is large, but requests are not so frequent (for example, each connection issues just a handful of requests per second)
---@field iproto_threads number (Default: 1) The number of network threads
---@field listen string|number (Default: nil) URI to bind tarantool
---@field log log (Default: nil) By default, Tarantool sends the log to the standard error stream (stderr). If log is specified, Tarantool sends the log to a file, or to a pipe, or to the system logger.
---@field log_format log_format (Default: 'plain')
---@field log_level log_level (Default: 5) What level of detail the log will have
---@field log_nonblock boolean (Default: true) If log_nonblock equals true, Tarantool does not block during logging when the system is not ready for writing, and drops the message instead
---@field memtx_dir string (Default: '.') path to dir with memtx snapshots
---@field memtx_max_tuple_size number (Default: 1024 * 1024) Size of the largest allocation unit, for the memtx storage engine. It can be increased if it is necessary to store large tuples
---@field memtx_memory number (Default: 256 * 1024 *1024) How much memory Tarantool allocates to actually store tuples
---@field memtx_min_tuple_size number (Default: 16) Size of the smallest allocation unit. It can be decreased if most of the tuples are very small
---@field net_msg_max number (Default: 768) To handle messages, Tarantool allocates fibers. To prevent fiber overhead from affecting the whole system, Tarantool restricts how many messages the fibers handle, so that some pending requests are blocked
---@field pid_file string (Default: nil) Store the process id in this file
---@field readahead number (Default: 16320) The size of the read-ahead buffer associated with a client connection
---@field read_only boolean (Default: false) should this instance be RO
---@field replicaset_uuid string (Generated automatically)
---@field replication string[] (Default: nil) list of URI of replicas to connect to
---@field replication_anon boolean (Default: false) A Tarantool replica can be anonymous. This type of replica is read-only (but you still can write to temporary and replica-local spaces), and it isn’t present in the _cluster table
---@field replication_connect_quorum number (Default: _cluster:len()) required number of connected replicas to start bootstrap
---@field replication_connect_timeout number (Default: 30) timeout in seconds to expect replicas in replication to fail bootstrap
---@field replication_synchro_quorum string|number (Default: N / 2 + 1. Before version 2.10.0, the default value was 1) number or formula of synchro quorum
---@field replication_skip_conflict boolean (Default: false) By default, if a replica adds a unique key that another replica has added, replication stops with error = ER_TUPLE_FOUND
---@field replication_sync_lag number (Default: 10) The maximum lag allowed for a replica
---@field replication_sync_timeout number (Default: 300) The number of seconds that a replica will wait when trying to sync with a master in a cluster, or a quorum of masters, after connecting or during configuration update
---@field replication_timeout number (Defailt: 1) If the master has no updates to send to the replicas, it sends heartbeat messages every replication_timeout seconds, and each replica sends an ACK packet back. Both master and replicas are programmed to drop the connection if they get no response in four replication_timeout periods. If the connection is dropped, a replica tries to reconnect to the master
---@field slab_alloc_factor number (Default: 1.05) The multiplier for computing the sizes of memory chunks that tuples are stored in. A lower value may result in less wasted memory depending on the total amount of memory available and the distribution of item sizes. Allowed values range from 1 to 2
---@field snap_io_rate_limit number (Default: nil) Reduce the throttling effect of box.snapshot() on INSERT/UPDATE/DELETE performance by setting a limit on how many megabytes per second it can write to disk. The same can be achieved by splitting wal_dir and memtx_dir locations and moving snapshots to a separate disk
---@field sql_cache_size number (Default: 5242880) The maximum number of bytes in the cache for SQL prepared statements
---@field strip_core boolean (Default: true) Whether coredump files should include memory allocated for tuples
---@field too_long_threshold number (Default: 0.5) If processing a request takes longer than the given value (in seconds), warn about it in the log. Has effect only if log_level is more than or equal to 4 (WARNING)
---@field username string (Default: nil) UNIX user name to switch to after start
---@field vinyl_bloom_fpr number (Default: 0.05) Bloom filter false positive rate – the suitable probability of the bloom filter to give a wrong result
---@field vinyl_cache number (Default: 128 * 1024 * 1024) The cache size for the vinyl storage engine
---@field vinyl_dir string (Default: '.') A directory where vinyl files or subdirectories will be stored. Can be relative to work_dir. If not specified, defaults to work_dir
---@field vinyl_max_tuple_size number (Default: 1024 * 1024) Size of the largest allocation unit, for the vinyl storage engine. It can be increased if it is necessary to store large tuples
---@field vinyl_memory number (Default: 128 * 1024 * 1024) The maximum number of in-memory bytes that vinyl uses
---@field vinyl_page_size number (Default: 8 * 1024) Page size. Page is a read/write unit for vinyl disk operations. The vinyl_page_size setting is a default value for one of the options in the Options for space_object:create_index() chart
---@field vinyl_range_size number (Default: nil) The default maximum range size for a vinyl index, in bytes. The maximum range size affects the decision whether to split a range. If vinyl_range_size is not nil and not 0, then it is used as the default value for the range_size option in the Options for space_object:create_index() chart. If vinyl_range_size is nil or 0, and range_size is not specified when the index is created, then Tarantool sets a value later depending on performance considerations. To see the actual value, use index_object:stat().range_size
---@field vinyl_read_threads number (Default: 1) The maximum number of read threads that vinyl can use for some concurrent operations, such as I/O and compression
---@field vinyl_run_count_per_level number (Default: 2) The maximal number of runs per level in vinyl LSM tree. If this number is exceeded, a new level is created. The vinyl_run_count_per_level setting is a default value for one of the options in the Options for space_object:create_index() chart
---@field vinyl_run_size_ratio number (Default: 3.5) Ratio between the sizes of different levels in the LSM tree. The vinyl_run_size_ratio setting is a default value for one of the options in the Options for space_object:create_index() chart
---@field vinyl_timeout number (Default: 60) The vinyl storage engine has a scheduler which does compaction. When vinyl is low on available memory, the compaction scheduler may be unable to keep up with incoming update requests. In that situation, queries may time out after vinyl_timeout seconds. This should rarely occur, since normally vinyl would throttle inserts when it is running low on compaction bandwidth. Compaction can also be ordered manually with index_object:compact()
---@field vinyl_write_threads number (Default: 4) The maximum number of write threads that vinyl can use for some concurrent operations, such as I/O and compression
---@field wal_dir string (Default: '.') path to dir with xlogs
---@field wal_dir_rescan_delay number (Default: 2) Number of seconds between periodic scans of the write-ahead-log file directory, when checking for changes to write-ahead-log files for the sake of replication or hot standby
---@field wal_max_size number (Default: 256 * 1024 * 1024) The maximum number of bytes in a single write-ahead log file. When a request would cause an .xlog file to become larger than wal_max_size, Tarantool creates another WAL file
---@field wal_mode wal_mode (Default: 'write') Specify fiber-WAL-disk synchronization mode as
---@field worker_pool_threads number (Default: 4) he maximum number of threads to use during execution of certain internal processes (currently socket.getaddrinfo() and coio_call())
---@field work_dir string (Default: nil) path to work dir of tarantool
box.cfg = {}
