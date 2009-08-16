From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: Add GCC pre-defined macros for user-space
Date: Sun, 16 Aug 2009 10:50:46 -0700
Message-ID: <70318cbf0908161050w4b95c04cme5f30157cba684df@mail.gmail.com>
References: <1250348235-19691-1-git-send-email-penberg@cs.helsinki.fi>
	 <70318cbf0908151236q2c691d73n5114ab21f3cbd819@mail.gmail.com>
	 <1250367991.14751.1.camel@penberg-laptop>
	 <20090815223602.GA4516@feather>
	 <1250406233.32343.9.camel@penberg-laptop>
	 <20090816105114.GA6489@feather>
	 <1250420733.9535.1.camel@penberg-laptop>
	 <20090816124157.GA6936@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f172.google.com ([209.85.212.172]:50502 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbZHPRup (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 16 Aug 2009 13:50:45 -0400
Received: by vws2 with SMTP id 2so2124985vws.4
        for <linux-sparse@vger.kernel.org>; Sun, 16 Aug 2009 10:50:46 -0700 (PDT)
In-Reply-To: <20090816124157.GA6936@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-sparse@vger.kernel.org

On Sun, Aug 16, 2009 at 5:41 AM, Josh Triplett<josh@joshtriplett.org> wrote:
> On Sun, Aug 16, 2009 at 02:05:33PM +0300, Pekka Enberg wrote:
>> Of course. Here's the final patch. *fingers crossed*
>
> Looks good to me.
>
> Acked-by: Josh Triplett <josh@joshtriplett.org>
>

Looks good to me too. I will apply.

The linux kernel has a STRING macro. I will rename to match
that if nobody objects.

Chris
