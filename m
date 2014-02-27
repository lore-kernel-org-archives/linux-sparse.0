From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V2] sparse: Allow override of sizeof(bool) warning
Date: Thu, 27 Feb 2014 13:00:41 -0800
Message-ID: <1393534841.24588.131.camel@joe-AO722>
References: <1393462087.24588.50.camel@joe-AO722>
	 <530E8C2E.7080307@zytor.com> <1393466619.24588.65.camel@joe-AO722>
	 <20140227022857.GC23659@thin> <1393469594.24588.71.camel@joe-AO722>
	 <20140227025845.GA25145@thin> <530EB103.5070406@zytor.com>
	 <1393472326.24588.82.camel@joe-AO722> <20140227040050.GA8449@nicira.com>
	 <530EBCED.9020705@zytor.com> <20140227042636.GA9592@nicira.com>
	 <530EBFC7.9030309@zytor.com>
	 <CANeU7Q=RNXR00bQcPzJYTOcZmRSn3U31ZcadPTHu6Y_Uk0UnYw@mail.gmail.com>
	 <faa9e231-d561-417b-8b8b-95192cb0e56a@email.android.com>
	 <CANeU7QnB1Yfd6SjLeUmB1Q-a+U6G221J8es7ckfjB-U45sAVMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:56162 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751072AbaB0VAo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 27 Feb 2014 16:00:44 -0500
In-Reply-To: <CANeU7QnB1Yfd6SjLeUmB1Q-a+U6G221J8es7ckfjB-U45sAVMA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ben Pfaff <blp@nicira.com>, Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 2014-02-27 at 12:44 -0800, Christopher Li wrote:
> On Thu, Feb 27, 2014 at 12:26 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> > I would.
> Joe, I assume you are OK with this patch, the default is now off.

Of course

> diff --git a/lib.c b/lib.c
[]
> @@ -226,6 +226,7 @@ int Wparen_string = 0;
> +int Wsizeof_bool = 0;


