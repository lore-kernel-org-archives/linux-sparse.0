Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EF71A3029
	for <linux-sparse@vger.kernel.org>; Mon, 23 Feb 2026 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855670; cv=none; b=ilpXtRqZMGYU1jwGjGhLS9OAZomMTN+k2pwoCVZ+YvOGjhvwicu5M/mTN5YSeuJnvOPrRHPPP8rukeud9MxmCyYgaVNL0CJk8IVAYSUa3p/x+mALNl4BnK5wlyuY6WRBBOkajDLB4cfYCwvXL/S4g+0zs+bbcta2eGnyUlwP2CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855670; c=relaxed/simple;
	bh=Pm8H26itj9WVrHtdsNa1I2+E1H4aCg58/ASSYEVz8YU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=SmDyPtvlva6rxs0AukRZnIv4/P3aBJwQMz/1P9+iv+ngXytGcWuU8KqCfY5ZRqQQuJlhDLL50G7hC5PRDHsBt1SZjnhEM8nLND7PRQH2yECYymYhcc/x/Jy/4m8AdC10lr4lGdVG+E1yBv9XQ4gXa3h+HU4BaX9Ctv2vqZvSLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=XnOXhhdT; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="XnOXhhdT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Cc; bh=qV9PKtzLG5EVW6vG3mJp5LQLtBsjhWR5owvE3Hn1jjE=; b=XnOXhhdTUfdF2WS2Rc1Sgv
	PN40MtoUSSS4KAZin+4ShvLWgDG1+P4KaSdx6pgdwlrPD7Q9wTopyohFV93V2ZMTmGr9ncRK8Y2FY
	eqX1T5HfGPlf2H99XZKaSELZb3gF1MwqUlcmytWiNZOZS8lkxC8gkS4gKZYY9P3aTDqNq0lZHsVW4
	amzYy6EpAvSTn1GmzSLJukO+kfb857DhI4HgEvUy+qfIMQPPrLPS+CY58ikdYnKT0YqkMqiGylTge
	0B3JCrTiCIbpfiSRfsuRDPVN1giEXP7p+QBS+AmnJtYcjf6y7PXYq2NlkrkjwsuXqpdlnR1vfFBOd
	s9+jGNnVN9Ww==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vuWbC-009vfw-7B
	for <linux-sparse@vger.kernel.org> ; Mon, 23 Feb 2026 14:07:46 +0000
Message-ID: <54d24dbb-eec2-4759-970c-4d7d3e48e6df@codethink.co.uk>
Date: Mon, 23 Feb 2026 14:07:45 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hang with current sparse with upstream linux arm64 build
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
References: <174fb380-6711-4305-b857-4b1ae86c74de@codethink.co.uk>
Content-Language: en-GB
Organization: Codethink Limited.
In-Reply-To: <174fb380-6711-4305-b857-4b1ae86c74de@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 23/02/2026 10:51, Ben Dooks wrote:
> Currently trying to run "make C=2" on the current upstream kernel using
> arm64 build and getting sparse processes hanging using 100% cpu and one
> with other 14minutes on the cpu.
> 
> sparse checkout is 37156835e3d725b6d750f000be33ba3814bb2310
> 
> kernel checkout is based on v7.0-rc1 
> 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f with some warning fixes on.
> 
> I've not yet tried a non-arm64 build or removing my warning fixes.
> 
> Attached my linux kenrel config just in case that's useful.

So currently it seems to be hanging when checking drivers/clk/clk.c
doing the following.

$ make C=1 drivers/clk/clk.o

This is working under v6.19 and not under v7.0-rc1

The git bisect is pointing to this commit

commit e19e1b480ac73c3e62ffebbca1174f0f511f43e7
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Feb 21 16:14:11 2026 -0800

     add default_gfp() helper macro and use it in the new *alloc_obj() 
helpers

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e19e1b480ac73c3e62ffebbca1174f0f511f43e7

The stderr output before it hangs is:
drivers/clk/clk.c:4124:15: error: Expected ) in function call
drivers/clk/clk.c:4124:15: error: got ,
drivers/clk/clk.c:4124:15: error: Expected ) in function call
drivers/clk/clk.c:4124:15: error: got ,
drivers/clk/clk.c:4124:15: error: Expected ) in function call
drivers/clk/clk.c:4124:15: error: got ,
drivers/clk/clk.c:4241:19: error: Expected ) in function call
drivers/clk/clk.c:4241:19: error: got ,
drivers/clk/clk.c:4241:19: error: Expected ) in function call
drivers/clk/clk.c:4241:19: error: got ,
drivers/clk/clk.c:4241:19: error: Expected ) in function call
drivers/clk/clk.c:4241:19: error: got ,
drivers/clk/clk.c:4331:16: error: Expected ) in function call
drivers/clk/clk.c:4331:16: error: got ,
drivers/clk/clk.c:4331:16: error: Expected ) in function call
drivers/clk/clk.c:4331:16: error: got ,
drivers/clk/clk.c:4331:16: error: Expected ) in function call
drivers/clk/clk.c:4331:16: error: got ,
drivers/clk/clk.c:4816:14: error: Expected ) in function call
drivers/clk/clk.c:4816:14: error: got ,
drivers/clk/clk.c:4816:14: error: Expected ) in function call
drivers/clk/clk.c:4816:14: error: got ,
drivers/clk/clk.c:4816:14: error: Expected ) in function call
drivers/clk/clk.c:4816:14: error: got ,
drivers/clk/clk.c:5012:14: error: Expected ) in function call
drivers/clk/clk.c:5012:14: error: got ,
drivers/clk/clk.c:5012:14: error: Expected ) in function call
drivers/clk/clk.c:5012:14: error: got ,
drivers/clk/clk.c:5012:14: error: Expected ) in function call
drivers/clk/clk.c:5054:14: error: Expected ) in function call
drivers/clk/clk.c:5054:14: error: got ,
drivers/clk/clk.c:5054:14: error: Expected ) in function call
drivers/clk/clk.c:5054:14: error: got ,
drivers/clk/clk.c:5054:14: error: Expected ) in function call
drivers/clk/clk.c:5054:14: error: got ,
drivers/clk/clk.c:5551:26: error: Expected ) in function call
drivers/clk/clk.c:5551:26: error: got ,
drivers/clk/clk.c:5551:26: error: Expected ) in function call
drivers/clk/clk.c:5551:26: error: got ,
drivers/clk/clk.c:5551:26: error: Expected ) in function call
drivers/clk/clk.c:5551:26: error: got ,
drivers/clk/clk.c:4124:15: error: undefined identifier '_res'
drivers/clk/clk.c:4124:15: error: undefined identifier '__VA_OPT__'
drivers/clk/clk.c:4124:15: error: undefined identifier '_res'
drivers/clk/clk.c:4124:15: error: undefined identifier '__VA_OPT__'
drivers/clk/clk.c:4124:15: error: undefined identifier '_res'
drivers/clk/clk.c:4241:19: error: undefined identifier '_res'
drivers/clk/clk.c:4241:19: error: undefined identifier '__VA_OPT__'
drivers/clk/clk.c:4241:19: error: undefined identifier '_res'
drivers/clk/clk.c:4241:19: error: undefined identifier '__VA_OPT__'
drivers/clk/clk.c:4241:19: error: undefined identifier '_res'
drivers/clk/clk.c:4331:16: error: undefined identifier '_res'
drivers/clk/clk.c:4331:16: error: undefined identifier '__VA_OPT__'
drivers/clk/clk.c:4331:16: error: undefined identifier '_res'
drivers/clk/clk.c:4331:16: error: undefined identifier '__VA_OPT__'
drivers/clk/clk.c:4331:16: error: undefined identifier '_res'
drivers/clk/clk.c:4816:14: error: undefined identifier '_res'
drivers/clk/clk.c:4816:14: error: undefined identifier '__VA_OPT__'
drivers/clk/clk.c:4816:14: error: undefined identifier '_res'
drivers/clk/clk.c:4816:14: error: undefined identifier '__VA_OPT__'
drivers/clk/clk.c:4816:14: error: undefined identifier '_res'
drivers/clk/clk.c:5012:14: error: undefined identifier '_res'
drivers/clk/clk.c:5012:14: error: undefined identifier '__VA_OPT__'
drivers/clk/clk.c:5012:14: error: undefined identifier '_res'
drivers/clk/clk.c:5012:14: error: undefined identifier '__VA_OPT__'
drivers/clk/clk.c:5012:14: error: undefined identifier '_res'
drivers/clk/clk.c:5054:14: error: undefined identifier '_res'
drivers/clk/clk.c:5054:14: error: undefined identifier '__VA_OPT__'
drivers/clk/clk.c:5054:14: error: undefined identifier '_res'


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
