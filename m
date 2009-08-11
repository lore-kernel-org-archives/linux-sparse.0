From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] make sparse headers self-compilable...
Date: Tue, 11 Aug 2009 14:08:24 -0700
Message-ID: <70318cbf0908111408u238bd057vd3e4578baa0fe32c@mail.gmail.com>
References: <200908072227.08652.kdudka@redhat.com>
	 <70318cbf0908110240w5067933dv92e92829c0bb2e8f@mail.gmail.com>
	 <200908111155.19586.kdudka@redhat.com>
	 <200908111240.06529.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f172.google.com ([209.85.212.172]:53836 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbZHKVIY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Aug 2009 17:08:24 -0400
Received: by vws2 with SMTP id 2so3642237vws.4
        for <linux-sparse@vger.kernel.org>; Tue, 11 Aug 2009 14:08:24 -0700 (PDT)
In-Reply-To: <200908111240.06529.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 11, 2009 at 3:40 AM, Kamil Dudka<kdudka@redhat.com> wrote:
> I agree processing of multiple-includes could be painful for the SPARSE
> preprocessor. But you don't solve it by avoiding multiple-includes in the
> SPARSE code itself. If you want to pass the SPARSE code through SPARSE, it's
> small enough to not bother us with performance.

I am worry about adding too much duplicated include slow down the
gcc compile of sparse itself. I know I am paranoid :-)

>
> But you have absolutely no control of the foreign code processed by SPARSE
> and there the performance impact could be significant. I think this is the
> way to go:
>
> http://gcc.gnu.org/onlinedocs/cppinternals/Guard-Macros.html

BTW, sparse does similar things already. That is what the stream->protect
was for.

Chris
