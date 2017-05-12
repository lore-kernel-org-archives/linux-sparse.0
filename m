From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [GIT PULL] last pending patches for sparse's next release
Date: Fri, 12 May 2017 17:26:36 +0100
Message-ID: <1de01159-2408-1596-6fcb-605b3b890fba@ramsayjones.plus.com>
References: <20170512111935.se6k5v2tlcwvtffc@desk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout08.plus.net ([212.159.14.20]:52413 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756345AbdELQeP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 12 May 2017 12:34:15 -0400
In-Reply-To: <20170512111935.se6k5v2tlcwvtffc@desk.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org



On 12/05/17 12:19, Luc Van Oostenryck wrote:
> Chris,
> 
> Please pull these patches for sparse's next release.
> There is 3 fixes, plus Lance's support for _Static_assert
> and the keyword cleanup that goes over it.

Hi Chris, Luc,

Sorry for the late report, but I tested current master/sparse-next
branches on 32-bit linux and sparse-next (@e35efe3 30-04-2017) has
fixed the three additional test failures.

Thanks!

ATB,
Ramsay Jones


