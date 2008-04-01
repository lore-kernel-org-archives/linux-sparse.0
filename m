From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: [PATCH] The require_context attribute
Date: Tue, 1 Apr 2008 17:10:27 +0300
Message-ID: <e51f66da0804010710x13711acdy8862b5632db94012@mail.gmail.com>
References: <200803311400.32860.philipp.reisner@linbit.com>
	 <82faac5b0804010307k498a18d5t1d4142e7e95385e0@mail.gmail.com>
	 <200804011600.05302.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:39854 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761AbYDAOK3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Apr 2008 10:10:29 -0400
Received: by nf-out-0910.google.com with SMTP id g13so843661nfb.21
        for <linux-sparse@vger.kernel.org>; Tue, 01 Apr 2008 07:10:27 -0700 (PDT)
In-Reply-To: <200804011600.05302.philipp.reisner@linbit.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Darren Jenkins <darrenrjenkins@gmail.com>, linux-sparse@vger.kernel.org

On 4/1/08, Philipp Reisner <philipp.reisner@linbit.com> wrote:
> Am Dienstag, 1. April 2008 12:07:17 schrieb Darren Jenkins:
> > G'day Philipp
>  >
>  > On Mon, Mar 31, 2008 at 11:00 PM, Philipp Reisner
>  >
>  > <philipp.reisner@linbit.com> wrote:
>  > >  +       ctc = &ctype->ctype;
>  > >  +       if (ctc)
>  > >  +               ad->ctx_reqs = ctc->ctx_reqs;
>  >
>  > is this right ? or am I just confused ?
>
> Good day Darren,
>
>  Could you elaborate in a bit more detail your concerns regarding
>  these lines ?

You take an address, how can it be NULL?

-- 
marko
