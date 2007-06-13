From: Pavel Roskin <proski@gnu.org>
Subject: Re: Messing typedefs?
Date: Wed, 13 Jun 2007 01:22:02 -0400
Message-ID: <1181712122.22924.15.camel@dv>
References: <OF97379DC1.5009215C-ONC12572F7.0034F56B-C12572F7.0041E12D@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:37962 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbXFMFWF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Jun 2007 01:22:05 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HyLIy-0002UD-GV
	for linux-sparse@vger.kernel.org; Wed, 13 Jun 2007 01:22:04 -0400
In-Reply-To: <OF97379DC1.5009215C-ONC12572F7.0034F56B-C12572F7.0041E12D@br-automation.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: linux-sparse@vger.kernel.org

Hello Thomas,

On Mon, 2007-06-11 at 13:59 +0200, Thomas Schmid wrote:
> Following code
> 
>         typedef unsigned char  plcbit;
>         typedef unsigned char  USINT;
> 
>         USINT usVar1;
> 
> leads to a symbol "usVar1" with base_type->ident named "plcbit".
> Is this behaviour expected?

This looks like a serious bug to me, although I'm surprised that it
doesn't seem to affect the sparse functionality (at least on the
surface).

What happens is the base types like uchar_ctype, which are supposed to
be initialized once and never changed again, are actually initialized by
the first typedef, so they are sort of "imprinted" with the new name.

This sparse was compiled without optimization to avoid any additional
weirdness.

(gdb) set args usvar.c
(gdb) tb main
Breakpoint 1 at 0x4017bc: file sparse.c, line 278.
(gdb) r
Starting program: /home/proski/src/sparse/sparse usvar.c
main (argc=2, argv=0x7fff6616d7e8) at sparse.c:278
278             struct string_list *filelist = NULL;
(gdb) watch uchar_ctype->ident
Hardware watchpoint 2: uchar_ctype->ident
(gdb) c
Continuing.
Hardware watchpoint 2: uchar_ctype->ident

Old value = (struct ident *) 0x0
New value = (struct ident *) 0x2b3e44959008
0x00000000004257bd in external_declaration (token=0x2b3e44988088, list=0x65ad70)
    at parse.c:2108
2108                            base_type->ident = ident;
(gdb) p *ident
$1 = {next = 0x0, symbols = 0x2b3e4497d548, len = 6 '\006', tainted = 0 '\0', 
  reserved = 0 '\0', keyword = 0 '\0', name = 0x2b3e4495901a "plcbit"}
(gdb)

And the code is:

        if (is_typedef) {
                if (base_type && !base_type->ident)
                        base_type->ident = ident;
        } else if (base_type && base_type->type == SYM_FN) {

I don't know what base_type->ident needs to be updated at all.  At least
SYM_BASETYPE should be exempt from this retroactive update.

-- 
Regards,
Pavel Roskin
