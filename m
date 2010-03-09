From: Pavel Roskin <proski@gnu.org>
Subject: Sparse crash when mixing int and enum in ternary operator
Date: Mon, 08 Mar 2010 20:24:32 -0500
Message-ID: <1268097872.16227.10.camel@mj>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:47114 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756420Ab0CIBYf (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 8 Mar 2010 20:24:35 -0500
Received: from [192.168.0.22] (unknown [72.92.88.10])
	by smtprelay2.cesmail.net (Postfix) with ESMTPSA id 821EC34C6A
	for <linux-sparse@vger.kernel.org>; Mon,  8 Mar 2010 20:24:44 -0500 (EST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

Sparse crashed when checking drivers/net/wireless/ath/ath9k/gpio.c in
Linux.  I could reduce the crash to the following simple program:

enum kind {
    GOOD
};
static void foo(enum kind k)
{
}
static void bar(int ok, int k)
{
    foo(ok ? GOOD : k);
}

Here's the gdb trace:

Starting program: /home/proski/bin/sparse kind.c
kind.c:9:12: warning: mixing different enum types

Program received signal SIGSEGV, Segmentation fault.
0x00000000004328bf in do_show_type (sym=0x3, name=0x7fffffffdda0) at show-parse.c:242
242             if (!sym || (sym->type != SYM_NODE && sym->type != SYM_ARRAY &&
(gdb) p sym
$1 = (struct symbol *) 0x3
(gdb) up
#1  0x0000000000432e95 in show_typename (sym=0x7ffff7f99190) at show-parse.c:379
379             do_show_type(sym, &name);
(gdb) p sym
$2 = (struct symbol *) 0x7ffff7f99190
(gdb) p *sym 
$3 = {type = SYM_ENUM, namespace = NS_NONE, used = 0 '\0', attr = 0 '\0', 
  enum_member = 0 '\0', bound = 0 '\0', pos = {type = 42, stream = 0, newline = 0, 
    whitespace = 0, pos = 0, line = 90177666, noexpand = 0}, endpos = {type = 9, stream = 0, 
    newline = 0, whitespace = 0, pos = 0, line = 2012974384, noexpand = 1}, ident = 0x0, 
  next_id = 0x7ffff7f99250, replace = 0x7ffff7fdaa20, scope = 0x0, {same_symbol = 0x0, 
    next_subobject = 0x0}, op = 0x3, {{expansion = 0x901700082, arglist = 0x668380, 
      used_in = 0x0}, {handler = 0x901700082, normal = 6718336}, {offset = 38678823042, 
      bit_size = 6718336, bit_offset = 0, arg_count = 0, variadic = 0, initialized = 0, 
      examined = 0, expanding = 0, evaluated = 0, string = 0, designated_init = 0, 
      array_size = 0x0, ctype = {modifiers = 140737353844496, alignment = 140737353984512, 
        contexts = 0x0, as = 0, base_type = 0x3}, arguments = 0x902400082, stmt = 0x668380, 
      symbol_list = 0x0, inline_stmt = 0x7ffff7fb8c50, inline_symbol_list = 0x7ffff7fdaa60, 
      initializer = 0x0, ep = 0x0, value = 3, definition = 0x905600082}}, {
    bb_target = 0x668380, aux = 0x668380, {kind = -128 '\200', visited = 1 '\1'}}, 
  pseudo = 0x0}
(gdb)

sym->ctype.base_type is 0x3, so sym becomes 0x3 after the first
iteration in do_show_type().

-- 
Regards,
Pavel Roskin
