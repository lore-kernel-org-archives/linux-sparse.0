From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 0/3] diagnose unknown escapes after preprocessing
Date: Tue, 7 Feb 2017 12:10:52 -0800
Message-ID: <2a9f4f21-ef0e-fb47-ffb8-76519fbad147@codeaurora.org>
References: <20170207174507.22722-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39344 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752811AbdBGUL1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 15:11:27 -0500
In-Reply-To: <20170207174507.22722-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christopher Li <sparse@chrisli.org>

On 02/07/2017 09:45 AM, Luc Van Oostenryck wrote:
> This series aims to solve the wrong warning recently 
> received when using sparse on Linux's kernel for arm64. 
> It quite straightforwardly move the diagnostic of
> unknown escape sequence together with escape conversion,
> after preprocessing.
>
> Patch 1 is just a test case (and could be folded with patch 2)
> Patch 2 is the fix in itself
> Patch 3 remove potential cruft left by patch 2.
>
>
> Luc Van Oostenryck (3):
>   add testcase for wrong early escape conversion
>   warn on unknown escapes after preprocessing
>   remove 'Escape' from token character class\

Thanks for the fix!

Tested-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

