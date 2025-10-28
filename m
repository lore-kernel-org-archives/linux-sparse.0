Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF93823535E
	for <linux-sparse@vger.kernel.org>; Tue, 28 Oct 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661679; cv=none; b=ILaGN1WpuKCRdb4/0L4+pcGHLl8eSkU/Mv3xo4yWM1rv+9Tde0xEZHr5N4qeZVyflJWIblSDO+riOBhRSTgPWfh92SP1Jdz9VBgbVPz1/N7naA/uJApMvRMIIjuBmY16uw1e6VZXCCzVzIETpuDnLXTZw5Lok1qKjvogow3s7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661679; c=relaxed/simple;
	bh=ZPdWymDxDKLpuG+bdnKFlGkWCrWPpLp7gTFSJ28qHlc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=qTWuzKH8fPT8rBEw8k51dXC8Wzkz8NRi8SqtBP3x8iy7yvCDl2OeC9vjjrK84KRmZ7Z4rPx/yWPlKE12kqxa6zitTTjc586cSDHMzzihdtW2li2jOSKgTvSTosswljDdynEDrkYGPAgh8uxlmGRq38t04rDXAoGKd+lcfAuMt3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzMigk13; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzMigk13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761661678; x=1793197678;
  h=date:from:to:subject:message-id:mime-version;
  bh=ZPdWymDxDKLpuG+bdnKFlGkWCrWPpLp7gTFSJ28qHlc=;
  b=BzMigk13L1evGFHHvaa3B4Uo8csKRus2JTMnn2VbhGhZzpXVJPAGAfmg
   YuYEvdXIrinv7S4KhUqw0HgsQTXkdTcUc0bp6kfdsQBxY/wU4PST6p5T2
   StGHFnflciXA16Pk9iDyk9WuNpN4+PcC7ApbmTINrxmrCsVKmWXvMnN7w
   RNqKiD3W4Bl6wxuZk8yRfjXRrPBMO2Jzxkb2t+5qLD+6OFgVmcHOJvawu
   vVB8HOz0MbfXBDXJW+fo5/mnqNyqCyOfxZalHReiou5XijdJMOQYouwXF
   g+67O3xMUMt4tnjQFZRi/TN1vD2gP62NqjqTzy2RqcPa8to0eq3GIvwSX
   g==;
X-CSE-ConnectionGUID: ElKgUmuWQBCqDBR8dvfp1g==
X-CSE-MsgGUID: jkeo2cxkTF6J2DcWm2ohfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81184293"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="81184293"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:27:58 -0700
X-CSE-ConnectionGUID: adXhdiIqRvKbhu75fxAzkw==
X-CSE-MsgGUID: 1d7oqPtPQoaXOJ/qrWq/SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="222570910"
Received: from belyakov-mobl.ccr.corp.intel.com (HELO ubuntu) ([10.94.251.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:27:57 -0700
Date: Tue, 28 Oct 2025 15:26:18 +0100 (CET)
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: linux-sparse@vger.kernel.org
Subject: [bug] false positive "invalid initializer"
Message-ID: <6dc61f89-b00c-3013-ef1c-9566f18e1592@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Hi

Using this example

void foo(void)
{
 	char c[] = "say";
 	__auto_type x = c;
 	const __typeof__(x) y = x;

 	(void)y;
}

results in

$ sparse -v -nostdinc -o ../l.o -c ../l.c
../l.c:4:25: error: invalid initializer
../l.c:5:33: error: invalid initializer

which appears to be a bug to me. Any fix suggestions would be appreciated.

Thanks
Guennadi
