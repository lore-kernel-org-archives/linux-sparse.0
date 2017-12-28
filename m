From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix implicit size of unsized arrays
Date: Thu, 28 Dec 2017 22:19:11 +0100
Message-ID: <20171228211911.4mkylgyk44ymtyna@ltop.local>
References: <20171228150747.77209-1-luc.vanoostenryck@gmail.com>
 <CACXZuxebnX36BjVyJjSecw7Uef0PaRcgYfLCgkqYz5tLrKHLpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:43568 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbdL1VTO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 16:19:14 -0500
Received: by mail-wm0-f52.google.com with SMTP id n138so45722080wmg.2
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 13:19:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxebnX36BjVyJjSecw7Uef0PaRcgYfLCgkqYz5tLrKHLpA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Dec 28, 2017 at 09:02:27PM +0000, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> Previous thread on this issue:
> 
> https://www.spinics.net/lists/linux-sparse/msg05427.html

Ah yes, sorry, I forgot you already specifically reported this one.
 
It should be fixed now.

-- Luc
