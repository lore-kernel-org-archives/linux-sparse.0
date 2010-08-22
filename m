From: Christopher Li <sparse@chrisli.org>
Subject: Re: modifier_string() inconsistency with modifiers
Date: Sun, 22 Aug 2010 10:25:30 -0700
Message-ID: <AANLkTinT5xhr+C4H71CWx3R9EqHy6ycp8gskjUqjts2Q@mail.gmail.com>
References: <1282300429.10440.230.camel@thorin>
	<AANLkTikugbBQ1gYVAdFRxWVmEX-odjq+Y5wA4mnN7Vnj@mail.gmail.com>
	<1282466539.5200.1.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52260 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab0HVRZc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 22 Aug 2010 13:25:32 -0400
Received: by ewy23 with SMTP id 23so2924700ewy.19
        for <linux-sparse@vger.kernel.org>; Sun, 22 Aug 2010 10:25:30 -0700 (PDT)
In-Reply-To: <1282466539.5200.1.camel@thorin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: linux-sparse@vger.kernel.org

On Sun, Aug 22, 2010 at 1:42 AM, Bernd Petrovitsch <bernd@sysprog.at> wrote:
> Not a big problem.
> Hmm, is it prudent to use c99, e.g. for named initializers und array?
>
Not at all. Sparse use c99 extensively.

Chris
