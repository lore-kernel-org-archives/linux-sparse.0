From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] parse: support c99 [static ...] in abstract array declarators
Date: Thu, 17 Apr 2014 22:52:59 -0700
Message-ID: <CANeU7Qn-CV1Raae1-E03tJCDidzV8tshwjE8M+JCh3r70zXokw@mail.gmail.com>
References: <1397603337-28016-1-git-send-email-cody@linux.vnet.ibm.com>
	<20140417001234.GA18426@leaf>
	<534F4F7F.5020506@linux.vnet.ibm.com>
	<20140417050914.GA21150@leaf>
	<CANeU7Q=qfD=fpP1k1gHpUxek4ZUuau3drCDncYr5eE18Xiq4Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:38037 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbaDRFxA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Apr 2014 01:53:00 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so1322133qgd.23
        for <linux-sparse@vger.kernel.org>; Thu, 17 Apr 2014 22:52:59 -0700 (PDT)
In-Reply-To: <CANeU7Q=qfD=fpP1k1gHpUxek4ZUuau3drCDncYr5eE18Xiq4Zw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Apr 16, 2014 at 11:50 PM, Christopher Li <sparse@chrisli.org> wrote:

> Here is a purpose patch with limited test. I expand the test to cover
> more static test case.
>
> Cody, does this patch work for you?

I apply the patch and push it out.

Please let me know if it breaks any thing.

Chris
