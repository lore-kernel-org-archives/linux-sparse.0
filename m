From: foobar <foobar@redchan.it>
Subject: sparse ctags segfaults (latest git)
Date: Mon, 1 Jan 2018 22:58:17 +0000
Message-ID: <20180101225817.3cb135dc04ea0195f28d8512@redchan.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from cock.li ([185.100.85.212]:36314 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752322AbeAAXFE (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 1 Jan 2018 18:05:04 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: foobar@redchan.it

git version 08890dcd7cc77b5d776768775484ed60fc23f08e
linux x64_64 (using musl libc)

gdb --args ./ctags ctags.c

Reading symbols from /home/foobar/sparse/ctags...done.
(gdb) r
Starting program: /home/foobar/sparse/./ctags ctags.c
warning: no loadable sections found in added symbol-file system-supplied DSO at 0x7ffff7ff9000
/usr/include/stdint.h:105:5: warning: constant 0xffffffffffffffffu is so big it is unsigned long
/usr/include/stdint.h:105:20: warning: constant 0xffffffffffffffffu is so big it is unsigned long

Program received signal SIGSEGV, Segmentation fault.
0x0000000000401703 in examine_symbol (sym=0x7ffff7fc2ff0) at ctags.c:138
138                     if (base->type == SYM_FN)
(gdb) p base
$1 = (struct symbol *) 0x0
(gdb) bt
#0  0x0000000000401703 in examine_symbol (sym=0x7ffff7fc2ff0) at ctags.c:138
#1  0x00000000004018c8 in examine_namespace (sym=0x7ffff7fc2ff0) at ctags.c:193
#2  0x0000000000401999 in examine_symbol_list (list=0x7ffff7fd7010) at ctags.c:209
#3  0x0000000000401aac in main (argc=2, argv=0x7fffffffeb68) at ctags.c:223
(gdb) p sym
$2 = (struct symbol *) 0x7ffff7fc2ff0
(gdb) l
133             add_tag(sym);
134             base = sym->ctype.base_type;
135
136             switch (sym->type) {
137             case SYM_NODE:
138                     if (base->type == SYM_FN)
139                             sym->kind = 'f';
140                     examine_symbol(base);
141                     break;
142             case SYM_STRUCT:
(gdb) 

