Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8AAC6FA94
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Sep 2022 16:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiIZQs5 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiIZQsI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 26 Sep 2022 12:48:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787B781B02;
        Mon, 26 Sep 2022 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664206891; x=1695742891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cJtS1l/hYLRTkrJK1zvNl4hftjTQqox5BLOaFPE0CkM=;
  b=ikA0iGIgd/4nYdxzlZP4VAEFJ6IZlKXJ/aIgXG9BDYTWPIb1KZx98h4d
   FLhOuZ/fsfEIG6GDfj0VcGxrCPWbMn1EdKkL4hasn3jmCJhyc1Jy7EmH6
   /+FxQSUGDGkMDmHAq8p28QpJeyILk1xMl/tdmVZlQe/dt3Bfb85MpG4GU
   wRnsr1bDrxn4/sLpx1SoeySYDsgarZ1HvX3FmPaqnMzZBnM0ZQEpHw+D5
   zatDmuM8gzPJJCoy7D/va5z+dyfcyMHZ0Iw+lCVBkdc2SLJcRYC6euLsK
   17gKag8Sr/ZJA24odGlvxC00mFHPfzO7iabS6ekvgbSFjpRCmYgGwSUjk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="281436123"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="281436123"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 08:41:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="763481118"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="763481118"
Received: from bsochack-mobl2.ger.corp.intel.com (HELO paris.ger.corp.intel.com) ([10.249.128.215])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 08:41:22 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@redhat.com,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        vitor@massaru.org, dlatypov@google.com, ndesaulniers@google.com,
        trix@redhat.com, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-sparse@vger.kernel.org,
        nathan@kernel.org, gustavoars@kernel.org,
        luc.vanoostenryck@gmail.com
Subject: [PATCH v12 9/9] drm/i915: Remove truncation warning for large objects
Date:   Mon, 26 Sep 2022 18:39:53 +0300
Message-Id: <20220926153953.3836470-10-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220926153953.3836470-1-gwan-gyeong.mun@intel.com>
References: <20220926153953.3836470-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

Having addressed the issues surrounding incorrect types for local
variables and potential integer truncation in using the scatterlist API,
we have closed all the loop holes we had previously identified with
dangerously large object creation. As such, we can eliminate the warning
put in place to remind us to complete the review.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Brian Welty <brian.welty@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Testcase: igt@gem_create@create-massive
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/4991
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_object.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index a826b959e3fb..7dc784079c6c 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -20,25 +20,10 @@
 
 enum intel_region_id;
 
-/*
- * XXX: There is a prevalence of the assumption that we fit the
- * object's page count inside a 32bit _signed_ variable. Let's document
- * this and catch if we ever need to fix it. In the meantime, if you do
- * spot such a local variable, please consider fixing!
- *
- * We can check for invalidly typed locals with typecheck(), see for example
- * i915_gem_object_get_sg().
- */
-#define GEM_CHECK_SIZE_OVERFLOW(sz) \
-	GEM_WARN_ON((sz) >> PAGE_SHIFT > INT_MAX)
-
 static inline bool i915_gem_object_size_2big(u64 size)
 {
 	struct drm_i915_gem_object *obj;
 
-	if (GEM_CHECK_SIZE_OVERFLOW(size))
-		return true;
-
 	if (overflows_type(size, obj->base.size))
 		return true;
 
-- 
2.37.1

