Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C6CC433EF
	for <linux-sparse@archiver.kernel.org>; Wed, 20 Apr 2022 12:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378603AbiDTMef (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 20 Apr 2022 08:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378573AbiDTMeY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Apr 2022 08:34:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5038E403E5
        for <linux-sparse@vger.kernel.org>; Wed, 20 Apr 2022 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650457898; x=1681993898;
  h=date:from:to:subject:message-id:mime-version;
  bh=5RDvTLJA1SP/JbQ4GQ7ob1Z0RdcOYWER/J7eZl+BT+I=;
  b=fAGgw/59bssMDNVJqGGTNGZehcj3N5BGOYD87nVjd0zdp1vxJgrOXgwo
   zFd1fVkV9J1dNCygo3n+Z177byWux4dJWUkYyKgeeFuNUT36w4qqEfduu
   H++DoEmCY7fwiEo8Cy8xhJg+UtgfkBKJWKthCYen3T4NVrhxX7j6Ln03u
   7pleK3ldSPw1/FWvmDG8Dn/ia38nzLDouRn2QMgVNv+IKwODbVjTEazfW
   6CMY1U25Ut0tqrppjlUCrDhE0MWLx7ROuQ9sJpRLSYSf53T6QX0sGnm7J
   HnVGkBCKivADLLJzHzcYrthwWHXuesHS7aojo7x0BH2dJvA1BKRIWwWrZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="350462764"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="350462764"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 05:31:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="555176649"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.251.215.80])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 05:31:36 -0700
Date:   Wed, 20 Apr 2022 14:31:34 +0200 (CEST)
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     linux-sparse@vger.kernel.org
Subject: [PATCH] cgcc: add Xtensa support
Message-ID: <144ce263-cb62-5531-b35-c8ab13ce68f7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add support for the Xtensa architecture.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---

This should be used with the Zephyr RTOS on Xtensa as implemented in 
https://github.com/zephyrproject-rtos/zephyr/pull/43776

  cgcc | 7 +++++++
  1 file changed, 7 insertions(+)

diff --git a/cgcc b/cgcc
index 9c78ee63..733cadfa 100755
--- a/cgcc
+++ b/cgcc
@@ -292,6 +292,9 @@ sub add_specs {
      } elsif ($spec eq 'aarch64') {
  	return (' --arch=aarch64' .
  		&float_types (1, 1, 36, [24,8], [53,11], [113,15]));
+    } elsif ($spec eq 'xtensa') {
+	return (' --arch=xtensa' .
+		&float_types (1, 1, 21, [24,8], [53,11], [53,11]));
      } elsif ($spec eq 'host_os_specs') {
  	my $os = `uname -s`;
  	chomp $os;
@@ -319,6 +322,8 @@ sub add_specs {
  	    return &add_specs ('x86_64') . ' -mx32';
  	} elsif ($gccmachine =~ '^x86_64-') {
  	    return &add_specs ('x86_64');
+	} elsif ($gccmachine =~ '^xtensa-') {
+	    return &add_specs ('xtensa');
  	}

  	# fall back to uname -m to determine the specifics.
@@ -348,6 +353,8 @@ sub add_specs {
  	    return &add_specs ('arm');
  	} elsif ($arch =~ /^(aarch64)$/i) {
  	    return &add_specs ('aarch64');
+	} elsif ($arch =~ /^(xtensa)$/i) {
+	    return &add_specs ('xtensa');
  	}
      } else {
  	die "$0: invalid specs: $spec\n";
-- 
2.30.2

