From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: Handling of -specs in cgcc
Date: Tue, 22 Jul 2008 21:28:26 +0400
Message-ID: <f19298770807221028x4f2dca08l36a31a9c381bf4f3@mail.gmail.com>
References: <f19298770807201128s3688702fm3f8b2f42edb198fc@mail.gmail.com>
	 <f19298770807221000o5905fefw44b0f420787baf9e@mail.gmail.com>
	 <118833cc0807221020m44938f77l70324a548baa4551@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:22489 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbYGVR23 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Jul 2008 13:28:29 -0400
Received: by yw-out-2324.google.com with SMTP id 9so835571ywe.1
        for <linux-sparse@vger.kernel.org>; Tue, 22 Jul 2008 10:28:28 -0700 (PDT)
In-Reply-To: <118833cc0807221020m44938f77l70324a548baa4551@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Morten Welinder <mwelinder@gmail.com>
Cc: linux-sparse@vger.kernel.org, Morten Welinder <terra@gnome.org>

On Tue, Jul 22, 2008 at 9:20 PM, Morten Welinder <mwelinder@gmail.com> wrote:
> On Tue, Jul 22, 2008 at 1:00 PM, Alexey Zaytsev
> <alexey.zaytsev@gmail.com> wrote:
>> [Added the new address to the CC]
>
> ("troll.com" is a bitkeeper bug.  Use a machine named "troll" and
> bitkeeper would
> happily add ".com".)
>
> With respect to the substance, I am not sure why you want to remove -specs.
> It was never meant to take a filename -- it takes a token like "i86" and adds
> options for that.  That is not generally very useful, but has its uses
> for cross-
> compilation.

But won't gcc fail in such case? Maybe we should not remove, but replace it
with a unique option to specify for which architecture sparse should check?

>
> Morten
>
