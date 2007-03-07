From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: sparse segfault in kernel -mm tree
Date: Tue, 6 Mar 2007 19:12:53 -0800
Message-ID: <70318cbf0703061912k73f19092p2f74ab7d4ae80afb@mail.gmail.com>
References: <20070305175322.cbe0bb66.rdunlap@xenotime.net>
	 <20070306023351.GB31138@chrisli.org>
	 <20070305210416.7b5c0a2a.rdunlap@xenotime.net>
	 <20070306004243.lvpk4ss8w8okw4ss@webmail.spamcop.net>
	 <20070305224025.fe867c28.rdunlap@xenotime.net>
	 <1173205177.32333.34.camel@dv>
	 <20070306125846.0e3a684a.rdunlap@xenotime.net>
	 <70318cbf0703061428u138a64b2x117eebdb915be50@mail.gmail.com>
	 <20070306190443.b8162bff.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:18278 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030777AbXCGDMz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Mar 2007 22:12:55 -0500
Received: by wr-out-0506.google.com with SMTP id 58so35523wri
        for <linux-sparse@vger.kernel.org>; Tue, 06 Mar 2007 19:12:54 -0800 (PST)
In-Reply-To: <20070306190443.b8162bff.rdunlap@xenotime.net>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

It seems that you are missing this change:

user:        Christopher Li <sparse@chrisli.org>
date:        Thu Feb 22 18:28:23 2007 -0800
summary:     Fix the segfault when initializer has unknown symbol

diff -r 9c425042a094 -r d22e36f6c600 expand.c
--- a/expand.c  Wed Feb 21 14:05:52 2007 -0800
+++ b/expand.c  Thu Feb 22 18:28:23 2007 -0800
@@ -872,7 +872,7 @@ static void verify_nonoverlapping(struct
        struct expression *b;

        FOR_EACH_PTR(*list, b) {
-               if (a && a->ctype->bit_size && bit_offset(a) == bit_offset(b)) {
+               if (a && a->ctype && a->ctype->bit_size &&
bit_offset(a) == bit_offset(b)) {
                        sparse_error(a->pos, "Initializer entry defined twice");
                        info(b->pos, "  also defined here");
                        return;

Many be the snapshot script need a restart again?

Chris

On 3/6/07, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On Tue, 6 Mar 2007 14:28:24 -0800 Christopher Li wrote:
> 875                     if (a && a->ctype->bit_size && bit_offset(a) == bit_offset(b)) {
> (gdb) bt
> #0  0x000000000040fd63 in expand_expression (expr=<value optimized out>)
