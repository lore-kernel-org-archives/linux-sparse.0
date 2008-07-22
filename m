From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: Handling of -specs in cgcc
Date: Tue, 22 Jul 2008 21:59:44 +0400
Message-ID: <f19298770807221059i607f5ea0lbe147ea360f6424b@mail.gmail.com>
References: <f19298770807201128s3688702fm3f8b2f42edb198fc@mail.gmail.com>
	 <f19298770807221000o5905fefw44b0f420787baf9e@mail.gmail.com>
	 <118833cc0807221020m44938f77l70324a548baa4551@mail.gmail.com>
	 <f19298770807221028x4f2dca08l36a31a9c381bf4f3@mail.gmail.com>
	 <118833cc0807221043n215f5378pa3f97bdf75452d0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:37526 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbYGVR7p (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Jul 2008 13:59:45 -0400
Received: by py-out-1112.google.com with SMTP id p76so1438394pyb.10
        for <linux-sparse@vger.kernel.org>; Tue, 22 Jul 2008 10:59:45 -0700 (PDT)
In-Reply-To: <118833cc0807221043n215f5378pa3f97bdf75452d0a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Morten Welinder <mwelinder@gmail.com>
Cc: linux-sparse@vger.kernel.org, Morten Welinder <terra@gnome.org>

On Tue, Jul 22, 2008 at 9:43 PM, Morten Welinder <mwelinder@gmail.com> wrote:
>> But won't gcc fail in such case?
>
> It will not fail, as gcc does not see any of it.  But since the defines might
> not match what gcc runs with, you might get interesting effects.
>

Rright, it is not added to the gcc arguments. But this means that if the
build system actually passes -specs= for some reason, gcc would never
see them... On the other hand, have anyone ever seen the -specs option
used in real life?

>> Maybe we should not remove, but replace it
>> with a unique option to specify for which architecture sparse should check?
>
> That's certainly possible, but I would wait for an actual problem showing
> up before fixing anything.  Right now, we can use -specs to get an idea
> what sparse would find for a different arch without actually having a gcc
> around that can cross compile.
>
> Morten
>
