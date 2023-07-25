Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF4AEB64DD
	for <linux-sparse@archiver.kernel.org>; Tue, 25 Jul 2023 06:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjGYGVA (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 25 Jul 2023 02:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGYGU7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 25 Jul 2023 02:20:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D630CF
        for <linux-sparse@vger.kernel.org>; Mon, 24 Jul 2023 23:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690266058; x=1721802058;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4WsPdOZq+qNXZQlwM/QDHN1S+j/nhasEsIGavrgtKvA=;
  b=n642KvunnuyG5n1CRYE4Hn1vglWxN37alYaxHjatpzHYhNyEm055rhPa
   v/1mHX0RY2HI/6jahnRprwc3JGZhnoJ0UIUfhjXgrqYXINqN+r+Xnlv1S
   OVOYxLmYn9y17kYbkISfjfb5scR0cXqxQ2CU8d7piTrznb4jmqA0RbrIk
   0SySLaHPTaz1lOVI52UEPqFiNiq7qLIoXeYrBJQK0CZZvTUeS/1jvWneF
   58Ko6bO/4LS5Mqle1FolGlOHT5siRwLCpCgrrNgMvkoD1VGyXdDfUo5gn
   1OYLjNHbCCIURZqm3+POO0kZDy1Ldeyi+KDkuO5ZNjghjGo9tMfpw1x/0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="370299264"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="370299264"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 23:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="729215591"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="729215591"
Received: from tskvortx-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.252.34.159])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 23:20:56 -0700
Date:   Tue, 25 Jul 2023 08:20:53 +0200 (CEST)
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [sparse] forgotten patch
In-Reply-To: <f6cf3f45-87de-f29b-8ace-f837772b21c@intel.com>
Message-ID: <732ac78e-9161-1fe5-f2eb-ec6f773814cb@intel.com>
References: <f6cf3f45-87de-f29b-8ace-f837772b21c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

Could you please pull the below patch. We've been using a private branch 
for SOF CI for 8 months now and this isn't a good place to be at: 
https://github.com/thesofproject/sof/blob/a38458dd2276fa24e37f5e60ef0a5613b03cbe00/.github/workflows/sparse-zephyr.yml#L33

Thanks
Guennadi

On Tue, 18 Apr 2023, Guennadi Liakhovetski wrote:

> Hi,
>
> Looks like this patch https://marc.info/?l=linux-sparse&m=166861736724543&w=2 
> has been forgotten? In general - where is the sparse development taking place 
> ATM - the https://git.kernel.org/pub/scm/devel/sparse/sparse.git/ repo seems 
> to not have been updated since last June?
>
> Thanks
> Guennadi
>
