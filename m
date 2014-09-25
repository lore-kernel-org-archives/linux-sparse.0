From: Christopher Li <sparse@chrisli.org>
Subject: Re: spurious warning for sizeof(bool)
Date: Thu, 25 Sep 2014 08:02:59 +0800
Message-ID: <CANeU7Q=qmxN_mKmxQ1NKGdC9rQnDVYOFP9AkAx-X2Qq4sbnfcA@mail.gmail.com>
References: <CAJhHMCAee+Q=P3oRdGhMcA_x0cbWShd+SkPyqzpDaT2=DjC=EQ@mail.gmail.com>
	<CAJhHMCDhai4WxRg5_1PQXq=MpO4a6Eyv9+Ep7hu09irnqJVHDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:56784 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbaIYADA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Sep 2014 20:03:00 -0400
Received: by mail-we0-f175.google.com with SMTP id u57so6134491wes.6
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2014 17:02:59 -0700 (PDT)
In-Reply-To: <CAJhHMCDhai4WxRg5_1PQXq=MpO4a6Eyv9+Ep7hu09irnqJVHDg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: "open list:SPARSE CHECKER" <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Thu, Sep 25, 2014 at 7:40 AM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> Is anyone reading these emails? :)
>>
>> I am getting these spurious warnings for a sizeof(bool) expression
>>
>> kernel/rcu/tree.c:202:14: warning: expression using sizeof bool
>>
>> Is this going to be fixed anytime soon?
>>

Which sparse version are you using? In the git chrisl repository,
sparse does not give that warning by default any more.

Chris
