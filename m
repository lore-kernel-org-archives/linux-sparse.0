From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH] sparse: Increase pre_buffer[] and check overflow
Date: Thu, 10 Jul 2008 14:09:37 -0400
Message-ID: <118833cc0807101109m6abcda96w492548d847b1a8c4@mail.gmail.com>
References: <20080709.002805.128619748.anemo@mba.ocn.ne.jp>
	 <20080709.005953.26097194.anemo@mba.ocn.ne.jp>
	 <20080710175100.GF28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20080710175100.GF28946@ZenIV.linux.org.uk>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-sparse@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-sparse@vger.kernel.org

> Not used anywhere in the tree:
> -D__DBL_MIN_EXP__='(-1021)' -D__HQ_FBIT__='15' -D__SFRACT_IBIT__='0'
> -D__FLT_MIN__='1.17549435e-38F' -D__UFRACT_MAX__='0XFFFFP-16UR'
> -D__DEC64_DEN__='0.000000000000001E-383DD' -D__DQ_FBIT__='63'
> -D__ULFRACT_FBIT__='32' -D__SACCUM_EPSILON__='0x1P-7HK'
> -D__CHAR_BIT__='8' -D__USQ_IBIT__='0' -D__ACCUM_FBIT__='15'

Wrong tree, :-)  Check your equivalent of
/usr/lib64/gcc/x86_64-suse-linux/4.1.0/include/float.h

The kernel probably doesn't care much, but sparse as a general tool
ought to care.

Morten
