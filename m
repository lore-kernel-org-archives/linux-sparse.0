From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [ANNOUNCE] Sparse v0.6.2-rc2
Date: Fri, 19 Jun 2020 00:15:40 +0200
Message-ID: <20200618221540.gvibhjj5fxiu4g4h@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFRWPo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 18 Jun 2020 18:15:44 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71418C06174E
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2020 15:15:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d15so6039541edm.10
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2020 15:15:44 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:4c3c:7f8a:3583:598e])
        by smtp.gmail.com with ESMTPSA id bd19sm3093212edb.2.2020.06.18.15.15.41
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 15:15:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Sparse v0.6.2-rc2 is now out.

The source code can be found at its usual repository:
  git://git.kernel.org/pub/scm/devel/sparse/sparse.git v0.6.1-rc2

The tarballs can be found at:
    https://www.kernel.org/pub/software/devel/sparse/dist/
with the following sha256sum:
    37347a72ed5c5465008d3f3f473f7c2fee68ad608887018f889dd65f97174b20  sparse-0.6.2-rc2.tar.gz
    685dfe9d7342b499e8137585bcf50bf4e42d548448b46a0ab578f3be5d212f2a  sparse-0.6.2-rc2.tar.xz


The changes since the -rc1 pre-release are:
* a bunch of spelling corrections in the documentation
* enum attributes are now parsed (and ignored)
* some build fixes for old versions of gcc or sqlite
* 'make CXX=...' can now be used to specify the C++ compiler
* the testsuite don't use anymore the option '-k' of 'timeout'
* remove commented-out code in optimize.c

-- Luc
