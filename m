From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: multiarch & base dir
Date: Sun, 5 Nov 2017 18:50:22 +0000
Message-ID: <ddd46aa0-8dbb-e644-ec46-56b235727438@ramsayjones.plus.com>
References: <20171105093301.adsucwshznehtdr4@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout04.plus.net ([212.159.14.19]:39921 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750817AbdKES54 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 13:57:56 -0500
In-Reply-To: <20171105093301.adsucwshznehtdr4@ltop.local>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org



On 05/11/17 09:33, Luc Van Oostenryck wrote:
> Hi,
> 
> Commit 85e2e2a25 "Add support for multiarch system header files"
> added for GCC's multiarch directory. One of the change was :
> +       /* add the multiarch include directories, if any */
> +       if (multiarch_dir && *multiarch_dir) {
> +               add_pre_buffer("#add_system \"/usr/include/%s\"\n", multiarch_dir);
> +               add_pre_buffer("#add_system \"/usr/local/include/%s\"\n", multiarch_dir);
> +       }
> 
> 
> There, the multiarch dir is appended to /usr/include & /usr/local/include.
> I'm wondering if using GCC_BASE should be used here instead.
> Any thoughts?

My initial reaction is definitely not! Certainly not _instead_ of
/usr/include and /usr/local/include. Adding GCC_BASE, which would
look something like: '/usr/lib/gcc/x86_64-linux-gnu/5', does not
immediately strike me as a good idea, but I haven't given it much
thought. ;-)

ATB,
Ramsay Jones

