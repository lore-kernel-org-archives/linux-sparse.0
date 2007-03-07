From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: sparse segfault in kernel -mm tree
Date: Tue, 6 Mar 2007 19:04:43 -0800
Message-ID: <20070306190443.b8162bff.rdunlap@xenotime.net>
References: <20070305175322.cbe0bb66.rdunlap@xenotime.net>
	<20070306023351.GB31138@chrisli.org>
	<20070305210416.7b5c0a2a.rdunlap@xenotime.net>
	<20070306004243.lvpk4ss8w8okw4ss@webmail.spamcop.net>
	<20070305224025.fe867c28.rdunlap@xenotime.net>
	<1173205177.32333.34.camel@dv>
	<20070306125846.0e3a684a.rdunlap@xenotime.net>
	<70318cbf0703061428u138a64b2x117eebdb915be50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:33291 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030779AbXCGDGd (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Mar 2007 22:06:33 -0500
Received: from midway.site ([71.245.96.156]) by xenotime.net for <linux-sparse@vger.kernel.org>; Tue, 6 Mar 2007 19:06:32 -0800
In-Reply-To: <70318cbf0703061428u138a64b2x117eebdb915be50@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Tue, 6 Mar 2007 14:28:24 -0800 Christopher Li wrote:

> Here is my version base on your email.
> 
> I need to change the gcc include path though. But it does not crash on me.
> 
> I did not get crash on allmodconfig either.

gdb backtrace of sparse segfault:


(gdb) set args vioc_prov.i
(gdb) run
Starting program: /home/rddunlap/bin/sparse vioc_prov.i

Program received signal SIGSEGV, Segmentation fault.
0x000000000040fd63 in expand_expression (expr=<value optimized out>)
    at expand.c:875
875                     if (a && a->ctype->bit_size && bit_offset(a) == bit_offset(b)) {
(gdb) bt
#0  0x000000000040fd63 in expand_expression (expr=<value optimized out>)
    at expand.c:875
#1  0x00000000004105a9 in expand_symbol (sym=<value optimized out>)
    at expand.c:993
#2  0x0000000000404581 in check_symbols (list=<value optimized out>)
    at sparse.c:265
#3  0x000000000040492a in main (argc=<value optimized out>, 
    argv=<value optimized out>) at sparse.c:280
(gdb) 



> Chris
> 
> On 3/6/07, Randy Dunlap <rdunlap@xenotime.net> wrote:
> > On Tue, 06 Mar 2007 13:19:37 -0500 Pavel Roskin wrote:
> > OK, that produced a large .i file and running:
> >   sparse vioc_provision.i
> > does reproduce the segfault, so now I am cutting down the size of
> > the .i file, then I'll send it in.


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
