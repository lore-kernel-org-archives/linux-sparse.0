From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 6/6] build: replace *_EXTRA_OBJS by local assignments to
 LDFLAGS and LOADLIBES
Date: Sat, 4 Nov 2017 14:10:54 +0100
Message-ID: <20171104131052.kiu27r3xud4zr2vx@ltop.local>
References: <20171004132605.24734-1-uwe@kleine-koenig.org>
 <20171004132605.24734-7-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:56082 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbdKDNLA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Nov 2017 09:11:00 -0400
Received: by mail-wm0-f48.google.com with SMTP id y83so6248763wmc.4
        for <linux-sparse@vger.kernel.org>; Sat, 04 Nov 2017 06:10:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171004132605.24734-7-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: linux-sparse@vger.kernel.org

On Wed, Oct 04, 2017 at 03:26:05PM +0200, Uwe Kleine-König wrote:
> This allows to drop the magic to handle *_EXTRA_OBJS.

I like it, especially for CFLAGS and LDFLAGS, but it also make things
slightly more complex to correctly support selfcheck.

-- Luc Van Oostenryck
