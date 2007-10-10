From: Andreas Schwab <schwab@suse.de>
Subject: Re: idio{,ma}tic typos (was Re: + fix-vm_can_nonlinear-check-in-sys_remap_file_pages.patch added to -mm tree)
Date: Wed, 10 Oct 2007 13:23:19 +0200
Message-ID: <je7ilvtdqw.fsf@sykes.suse.de>
References: <20071010104540.GA6366@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:48720 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983AbXJJLXY (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Oct 2007 07:23:24 -0400
In-Reply-To: <20071010104540.GA6366@localhost.sw.ru> (Alexey Dobriyan's
	message of "Wed\, 10 Oct 2007 14\:45\:40 +0400")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Dobriyan <adobriyan@sw.ru>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, Pierre Ossman <drzeus@drzeus.cx>, akpm@osdl.org, linux-sparse@vger.kernel.org

Alexey Dobriyan <adobriyan@sw.ru> writes:

> --- a/drivers/net/wireless/arlan.h
> +++ b/drivers/net/wireless/arlan.h
> @@ -485,7 +485,7 @@ struct arlan_private {
>  #define clearClearInterrupt(dev){\
>     writeControlRegister(dev,readControlRegister(dev) & ~ARLAN_CLEAR_=
INTERRUPT);}
>  #define setPowerOff(dev){\
> -   writeControlRegister(dev,readControlRegister(dev) | (ARLAN_POWER =
&& ARLAN_ACCESS));\
> +   writeControlRegister(dev,readControlRegister(dev) | (ARLAN_POWER =
& ARLAN_ACCESS));\

Methinks that this actually wants (ARLAN_POWER | ARLAN_ACCESS), since
(ARLAN_POWER & ARLAN_ACCESS) =3D=3D 0.

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
