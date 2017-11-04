From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 5/6] build: pass standard make variables to compiler and
 linker
Date: Sat, 4 Nov 2017 07:43:44 +0100
Message-ID: <20171104064341.4oqqqoa2lfuc3xd3@ltop.local>
References: <20171004132605.24734-1-uwe@kleine-koenig.org>
 <20171004132605.24734-6-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:48458 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbdKDGnt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Nov 2017 02:43:49 -0400
Received: by mail-wm0-f52.google.com with SMTP id p75so5024160wmg.3
        for <linux-sparse@vger.kernel.org>; Fri, 03 Nov 2017 23:43:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171004132605.24734-6-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: linux-sparse@vger.kernel.org

On Wed, Oct 04, 2017 at 03:26:04PM +0200, Uwe Kleine-König wrote:
> Add all variables that make's builtin rules pass to compiler and linker.
> 
> I don't know a user of TARGET_ARCH but Debian packages use CPPFLAGS to
> pass -D_FORTIFY_SOURCE=2 for hardening.

I've looked a bit at this. What I think is:
- LOADLIBES & LDLIBS are standard (g)make variables but I don't think
  there is any reasons to allow them to be overriden from the command
  line or the environment.
- TARGET_ARCH is a strange beast, it seems the intention was for
  something like '-march=armv7' which should be OK here but the only
  use I saw was to hold the output of 'uname -m'.
  I think it's better to not have it here
- of course the change for CPPFLAGS is completly legitimate.

-- Luc
