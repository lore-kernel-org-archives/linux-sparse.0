From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] byteswap: don't use __builtin_bswap*() with sparse
Date: Thu, 11 Aug 2016 13:55:48 +0200
Message-ID: <2133648.lb1RCaYlXp@wuerfel>
References: <1470914102-26389-1-git-send-email-johannes@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470914102-26389-1-git-send-email-johannes@sipsolutions.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-sparse@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
List-Id: linux-sparse@vger.kernel.org

On Thursday, August 11, 2016 1:15:02 PM CEST Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Although sparse declares __builtin_bswap*(), it can't actually
> do constant folding inside them (yet). As such, things like
> 
>   switch (protocol) {
>   case htons(ETH_P_IP):
>           break;
>   }
> 
> which we do all over the place cause sparse to warn that it
> expects a constant instead of a function call.
> 
> Disable __HAVE_BUILTIN_BSWAP*__ if __CHECKER__ is defined to
> avoid this.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7322dd755e7d ("byteswap: try to avoid __builtin_constant_p gcc bug")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Looks good, thanks for addressing this!

Acked-by: Arnd Bergmann <arnd@arndb.de>
