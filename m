From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: Handling of -specs in cgcc
Date: Tue, 22 Jul 2008 13:20:45 -0400
Message-ID: <118833cc0807221020m44938f77l70324a548baa4551@mail.gmail.com>
References: <f19298770807201128s3688702fm3f8b2f42edb198fc@mail.gmail.com>
	 <f19298770807221000o5905fefw44b0f420787baf9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:21376 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbYGVRUr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Jul 2008 13:20:47 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1033671wri.5
        for <linux-sparse@vger.kernel.org>; Tue, 22 Jul 2008 10:20:46 -0700 (PDT)
In-Reply-To: <f19298770807221000o5905fefw44b0f420787baf9e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: linux-sparse@vger.kernel.org, Morten Welinder <terra@gnome.org>

On Tue, Jul 22, 2008 at 1:00 PM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:
> [Added the new address to the CC]

("troll.com" is a bitkeeper bug.  Use a machine named "troll" and
bitkeeper would
happily add ".com".)

With respect to the substance, I am not sure why you want to remove -specs.
It was never meant to take a filename -- it takes a token like "i86" and adds
options for that.  That is not generally very useful, but has its uses
for cross-
compilation.

Morten
