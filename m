Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7983BC433EF
	for <linux-sparse@archiver.kernel.org>; Fri,  1 Jul 2022 12:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbiGAMM7 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 1 Jul 2022 08:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbiGAMM4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 1 Jul 2022 08:12:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9E98734D
        for <linux-sparse@vger.kernel.org>; Fri,  1 Jul 2022 05:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656677575; x=1688213575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qv4kLKxH0W7SU07rNjlbVClL2PstfgZsWvIXqa8Wkp0=;
  b=HJwsGi620fBV2fLqHR6fGGlKvtYXarxhDOxa1Ra8cxo/1MMF7SYd3end
   JP/i6mn4ggahEVlFGW3GESoyIAFUSib1G231IoziaoSpL5mjryfwYiHyG
   WKIkMYEXOmAlkFgfu5l/YNk0pR87z6wMM0WdB0dgfIqk4/Fna2EgfivXP
   4hYECa2dUoEdvglzbmOKRF0ii1fCTNb5x+1XuTav53MNC8iTcO84N6HaM
   p5LzTpu4NV6qR3B+ugNO/IfG9xRlkJCZFgUUk6QdhGEZutaOUDhBzuTR2
   x9axuwlwyroqvoh6xookaRm8l67/z1mr+8WfoNgs1txDhBKyfQSEj9DoK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="283371567"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="283371567"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 05:12:52 -0700
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="659412276"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 05:12:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1o7FTo-0012uJ-1f;
        Fri, 01 Jul 2022 15:10:36 +0300
Date:   Fri, 1 Jul 2022 15:10:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Luc Van Oostenryck <lucvoo@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>
Cc:     linux-sparse@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fix "unreplaced" warnings caused by using typeof() on
 inline functions
Message-ID: <Yr7kPM1wLZnOqxOA@smile.fi.intel.com>
References: <20220624164601.99527-1-lucvoo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624164601.99527-1-lucvoo@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Jun 24, 2022 at 06:46:01PM +0200, Luc Van Oostenryck wrote:
> From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> Currently, sparse do all its inlining at the tree level, during
> constant expansion. To not mix-up the evaluation of the original
> function body in case the address of an inline function is taken or
> when the function can't otherwise be inlined, the statements and
> symbols lists of inline functions are kept in separated fields.
> Then, if the original body must be evaluated it must first be
> 'uninlined' to have a copy in the usual fields.
> 
> This make sense when dealing with the definition of the function.
> But, when using typeof() on functions, the resulting type doesn't
> refer to this definition, it's just a copy of the type and only
> of the type. There shouldn't be any reasons to uninline anything.
> However, the distinction between 'full function' and 'type only'
> is not made during evaluation and the uninlining attempt produce
> a lot of "warning: unreplaced symbol '...'" because of the lack
> of a corresponding definition.
> 
> Fix this by not doing the uninlining if the symbol lack a definition.
> 
> Note: It would maybe be more appropriate for EXPR_TYPE to use
>       a stripped-own version of evaluate_symbol() doing only the
>       examination of the return and argument types, bypassing the
>       attempt to uninline the body and evaluate the initializer and
>       the statements since there is none of those for an EXPR_TYPE.

Uwe, can we get a Debian package with this fix, it's really a tons of such
messages when compile kernel with C=1?

-- 
With Best Regards,
Andy Shevchenko


