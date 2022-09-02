Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9F8C38145
	for <linux-sparse@archiver.kernel.org>; Fri,  2 Sep 2022 10:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiIBKDA (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 2 Sep 2022 06:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiIBKC7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Sep 2022 06:02:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BEE9E11D
        for <linux-sparse@vger.kernel.org>; Fri,  2 Sep 2022 03:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662112979; x=1693648979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zgRVNIHnlowY0e1WXuhx0DMVtXHR0lQUoznw/MLyrIg=;
  b=LDdS2/gU74VYTJzhhYF1a8IxaMfztjTOs6jZiNkWfkk38Vp6nWcaMF41
   odLWX1SVdD20Dp9Gobp6hzygHL320p+1d/Fe7W/0/PlBDNH40gE9p94pn
   ywZOPLYPfbzOts9qkHb4U5Q7r15oQNkSotPSjuldzn1XsUv7dNNlQv9OR
   27aNueQA14HQ0s+HJ/K/sMmytm9b4PIvw9/InlKC9ovYMxVz8riJfX/4S
   EqAk+fqIGwERe2rwWWMV6/gVGhHn7/DPoUdQCZJId8kRANzoxzuKDiPab
   vvKQPqDP5jxQXyCh2awZNHNvCG4Upfm6psxJqQ+9pbgXpaBg7k1Hjceie
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="294688511"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="294688511"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 03:02:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="681239296"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 03:02:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oU3Vd-007K0H-1w;
        Fri, 02 Sep 2022 13:02:45 +0300
Date:   Fri, 2 Sep 2022 13:02:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Luc Van Oostenryck <lucvoo@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>
Cc:     linux-sparse@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fix "unreplaced" warnings caused by using typeof() on
 inline functions
Message-ID: <YxHUxfOxDuwe9k1n@smile.fi.intel.com>
References: <20220624164601.99527-1-lucvoo@kernel.org>
 <Yr7kPM1wLZnOqxOA@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr7kPM1wLZnOqxOA@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Jul 01, 2022 at 03:10:36PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 24, 2022 at 06:46:01PM +0200, Luc Van Oostenryck wrote:
> > From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > 
> > Currently, sparse do all its inlining at the tree level, during
> > constant expansion. To not mix-up the evaluation of the original
> > function body in case the address of an inline function is taken or
> > when the function can't otherwise be inlined, the statements and
> > symbols lists of inline functions are kept in separated fields.
> > Then, if the original body must be evaluated it must first be
> > 'uninlined' to have a copy in the usual fields.
> > 
> > This make sense when dealing with the definition of the function.
> > But, when using typeof() on functions, the resulting type doesn't
> > refer to this definition, it's just a copy of the type and only
> > of the type. There shouldn't be any reasons to uninline anything.
> > However, the distinction between 'full function' and 'type only'
> > is not made during evaluation and the uninlining attempt produce
> > a lot of "warning: unreplaced symbol '...'" because of the lack
> > of a corresponding definition.
> > 
> > Fix this by not doing the uninlining if the symbol lack a definition.
> > 
> > Note: It would maybe be more appropriate for EXPR_TYPE to use
> >       a stripped-own version of evaluate_symbol() doing only the
> >       examination of the return and argument types, bypassing the
> >       attempt to uninline the body and evaluate the initializer and
> >       the statements since there is none of those for an EXPR_TYPE.
> 
> Uwe, can we get a Debian package with this fix, it's really a tons of such
> messages when compile kernel with C=1?

As of today it seems Debian still has old sparse version...

-- 
With Best Regards,
Andy Shevchenko


