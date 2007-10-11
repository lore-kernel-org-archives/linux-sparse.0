From: Josh Triplett <josh@freedesktop.org>
Subject: Re: idio{,ma}tic typos (was Re: + fix-vm_can_nonlinear-check-in-sys_remap_file_pages.patch
 added to -mm tree)
Date: Thu, 11 Oct 2007 09:27:21 -0700
Message-ID: <470E4EE9.1020102@freedesktop.org>
References: <20071010104540.GA6366@localhost.sw.ru> <470CBB6A.7020305@freedesktop.org> <20071011073537.GA6697@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:33971 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbXJKQ12 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Oct 2007 12:27:28 -0400
In-Reply-To: <20071011073537.GA6697@localhost.sw.ru>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Dobriyan <adobriyan@sw.ru>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, Pierre Ossman <drzeus@drzeus.cx>, akpm@osdl.org, linux-sparse@vger.kernel.org

Alexey Dobriyan wrote:
> On Wed, Oct 10, 2007 at 04:45:46AM -0700, Josh Triplett wrote:
>> Alexey Dobriyan wrote:
>>> ["if (!x & y)" patch from yanzheng@]
>>> ["if (!x & y)" patch from adobriyan@]
>>> ["if (!x & y)" patches from viro@]
>>>
>>> While we're at it, below is somewhat ugly sparse patch for detecting
>>> "&& 0x" typos.
>> Excellent idea!  I think it applies to || as well.
> 
> Sadly, yes.
> 
> [PATCH] smctr: fix "|| 0x" typo
> 
> IBM_PASS_SOURCE_ADDR is 1, so logically ORing it with status bits is
> pretty useless. Do bitwise OR, instead.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@sw.ru>
> ---
> 
>  drivers/net/tokenring/smctr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/net/tokenring/smctr.c
> +++ b/drivers/net/tokenring/smctr.c
> @@ -3413,7 +3413,7 @@ static int smctr_make_tx_status_code(struct net_device *dev,
>          tsv->svi = TRANSMIT_STATUS_CODE;
>          tsv->svl = S_TRANSMIT_STATUS_CODE;
>  
> -        tsv->svv[0] = ((tx_fstatus & 0x0100 >> 6) || IBM_PASS_SOURCE_ADDR);
> +        tsv->svv[0] = ((tx_fstatus & 0x0100 >> 6) | IBM_PASS_SOURCE_ADDR);
>  
>          /* Stripped frame status of Transmitted Frame */
>          tsv->svv[1] = tx_fstatus & 0xff;

Nice catch.  I agree with Kyle, though, that fixing it may require
some care to make sure it doesn't break things relying on the bug.

>> I'll most likely
>> add a -Wboolean-logic-on-bit-constant to turn this warning on.
> 
> Ewww, more options. :-(

With heuristic warnings like this, people need a way to turn them off.

>> Any reason why this wouldn't apply to octal constants or to GCC's new
>> binary constants?  I can trivially modify this patch to handle those
>> as well, just by dropping the check for an 'x' or 'X', and renaming the
>> flag.
> 
> OK, let me try too.

Go for it.  I look forward to your next patch.

Thanks,
Josh Triplett
