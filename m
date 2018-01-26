From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] lib.c: early return from handle_onoff_switch()
Date: Fri, 26 Jan 2018 08:21:13 +0100
Message-ID: <20180126072111.2xyh2yl2brhblxu4@ltop.local>
References: <d198c16f-9dcf-3238-942f-889c4322ba54@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39991 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbeAZHVR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 26 Jan 2018 02:21:17 -0500
Received: by mail-wm0-f46.google.com with SMTP id v123so19182841wmd.5
        for <linux-sparse@vger.kernel.org>; Thu, 25 Jan 2018 23:21:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <d198c16f-9dcf-3238-942f-889c4322ba54@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Thu, Jan 25, 2018 at 06:12:54PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> When handling "-Wsparse-all" in handle_onoff_switch(), once all
> warning flags have been set, the function can return instead of
> checking for "no-" or other option names because they won't be
> found. Just return NULL, which is what happens when handling
> "-Wsparse-all" anyway.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
