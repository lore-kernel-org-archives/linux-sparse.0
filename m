From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 0/6] testsuite speedup
Date: Sun, 28 May 2017 23:04:28 +0100
Message-ID: <47420cd6-74bc-8037-5d92-7e65f8aa8560@ramsayjones.plus.com>
References: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout08.plus.net ([212.159.14.20]:58945 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdE1WEa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 May 2017 18:04:30 -0400
In-Reply-To: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org



On 28/05/17 20:29, Luc Van Oostenryck wrote:
> The goal of this series is to speedup the testsuite,
> mainly by avoiding to unneedlessly spawn child processes.
> 
> The resulting speedup here is over 2.5, which is quite appreciable.

I would have liked to try these out, particularly on cygwin, but I
could not get them to apply. (patch #4 has a line: 'rm -f $file.{error,output}.{expected,got,diff}' in the context which I don't have).

I was attempting to apply on top of 'sparse-next-20170516'.
Should I apply to a different branch?
Were they built on a branch I don't have?

ATB,
Ramsay Jones

