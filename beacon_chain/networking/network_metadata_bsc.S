#if defined(__APPLE__)
# define cdecl(s) _##s
#else
# define cdecl(s) s
#endif

#if defined(__linux__)
    .section  .note.GNU-stack, "", @progbits
    .section .rodata,"a",@progbits
#elif defined(__APPLE__)
    .section __TEXT,__const
#elif defined(__WIN32__)
    .section .rdata,"dr"
#else
    .text
#endif

# name_data = start of data
# name_end = end of data (without alignment)
# name = 64-bit pointer to data
# name_size = 64-bit length in bytes

eth2_bsc_genesis_data:
    .incbin "eth2-networks/shared/bsc/genesis.ssz"
eth2_bsc_genesis_end:
    .global cdecl(eth2_bsc_genesis_size)
cdecl(eth2_bsc_genesis_size):
    .quad    eth2_bsc_genesis_end - eth2_bsc_genesis_data

eth2_goerli_genesis_data:
    .incbin "eth2-networks/shared/prater/genesis.ssz"
eth2_goerli_genesis_end:
    .global cdecl(eth2_goerli_genesis_size)
cdecl(eth2_goerli_genesis_size):
    .quad    eth2_goerli_genesis_end - eth2_goerli_genesis_data

eth2_sepolia_genesis_data:
    .incbin "sepolia/bepolia/genesis.ssz"
eth2_sepolia_genesis_end:
    .global cdecl(eth2_sepolia_genesis_size)
cdecl(eth2_sepolia_genesis_size):
    .quad    eth2_sepolia_genesis_end - eth2_sepolia_genesis_data

#if defined(__linux__) && defined(__pie__)
    .section	.data.rel.ro,"aw",@progbits
#elif defined(__APPLE__)
    .section __DATA,__const
#endif

    .global cdecl(eth2_bsc_genesis)
    .p2align 3
cdecl(eth2_bsc_genesis):
    .quad eth2_bsc_genesis_data

    .global cdecl(eth2_goerli_genesis)
    .p2align 3
cdecl(eth2_goerli_genesis):
    .quad eth2_goerli_genesis_data

    .global cdecl(eth2_sepolia_genesis)
    .p2align 3
cdecl(eth2_sepolia_genesis):
    .quad eth2_sepolia_genesis_data
