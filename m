Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538703;
	b=KxcLamuTxSFKs+ujMIQC+qL0SwP/oHqb/h+i28GAGZfsP88zf2qU8DBFaTIUyZ1BSVsw
	 kF3y03Kfamp2QbimKufF8IIv8is2XOGTl+nrd5l2ZOzQXYPQ5PMI8edc/gQ7l+dRd0R8u
	 y6oy6k0kSOTOBGdh+mMcW6q3LkM11cyl4sk+999S6mPK/uHCVtboy8yNVSNyr9+J6jhER
	 ZggGA6Kpi3mvsgs/beT20ENBy2S0QA6WhbKEa/sztGRzKmOXGwnL9QqmQe5vw2cBlKylZ
	 nvbJtHpGDP498pYS+Ke+lwtbsDb7Dc0dazenxzcao1I8DJemjRxHmc7tKdU3fT93gbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538703;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jaMI51BbORS69FqpxFYJrqCgzBf7eHo4MXrQiJASQ5g=;
	b=W1RwuGg1R8cK3YR4QmkD2G9TkM0tqFgEvrrUyZkLcRaDFkNpxjWXd4yO17ox4HOK5sfs
	 Hq7KgdasmDiLHyiKApgKyuKAhjGubc3uuQNRJXQlII8GzsO4lUt1Mt/wx++fA8eVRQibK
	 5R03Lj1v4eWajYiG8TqG942R07Ub6kpC9Oen1pKG68c3DSVzIQXluH+dZlpYjsnhvbi8Z
	 7t2lsgdtjCbmglnYWL9a6JwhO94MI6zoJVX0ZwVielmrE8ZvhtpQ1jxraY6z1LKqEbtGS
	 oT3mhNZ08k5gkZqiiQM9zOmuowlqcHwaNVAHSO4zilHdObI+6EcH8RRwS9ZjLHincjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=bXfYRebI;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0845606A32D
	for <linux-sparse@vger.kernel.org>; Tue, 24 Nov 2026 16:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0845606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=bXfYRebI
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jYpZJ1sDyz1XM5kD;
	Tue, 24 Nov 2026 16:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:from:from:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795538695; x=1798130696; bh=jaMI51BbORS69FqpxFYJrqCg
	zBf7eHo4MXrQiJASQ5g=; b=bXfYRebIcl3jpMinmMJriYAOYH3QpGhBpim67+KO
	hUsXjbyktN1rIbXbPNFsz7zPSnQg5i4s1SnQCN8354xtYyESSN/Xosfs1FnXMzXN
	E2alIDgvHyq1CJoMRV6nrksfneFKLQiQbvMt9aPuPrLT57n9kD3I7OtZ04q3LTaq
	tFCJYcs4VbbaSkOnhitidGafpOL4TQ0YatBp3Ln9Y/buZYSKNWDWgiwagnpV7Y6g
	3b+JMEXIiqQUkaFSWW8Yfjtt8efzRu35oG11M4ZtHgorL3g4qx0T8ATwoD1+x4qN
	Ziw/Kkg9hT7zjbE7p0voHkWJG8YTbJPC9VWRqoVxmsyDfQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id FaKL6j46rGyn; Tue, 24 Nov 2026 16:44:55 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:b87d:aea9:8f72:a6cd] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jYpZH0fC5z1XM4Tn;
	Tue, 24 Nov 2026 16:44:55 +0000 (UTC)
Message-ID: <d9ef968b-39aa-431d-9c90-5641299d489b@acm.org>
Date: Tue, 24 Nov 2026 08:44:54 -0800
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH 00/73] Support more C23 features
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
References: <20261109203259.362845-1-bvanassche@acm.org>
Content-Language: en-US
In-Reply-To: <20261109203259.362845-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/26 12:31 PM, Bart Van Assche wrote:
> If nobody objects I will publish this patch series two weeks from now to
> the master branch at kernel.org.

This patch series has been published with only one change. The only 
change that has been made is a robustness improvement for a GitHub
workflow and can be found below:

diff --git a/ci/build-linux-kernel-with-sparse.sh 
b/ci/build-linux-kernel-with-sparse.sh
index 7e3505634d95..761de6e1383b 100755
--- a/ci/build-linux-kernel-with-sparse.sh
+++ b/ci/build-linux-kernel-with-sparse.sh
@@ -10,7 +10,14 @@ rm -rf linux-kernel
  if [ -e ../linux-kernel ]; then
      git clone ../linux-kernel linux-kernel
  else
-    git clone --depth=3 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
linux-kernel
+    for url in https://github.com/torvalds/linux.git \
+ 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git; do
+       if git clone --depth=3 "$url" linux-kernel; then
+           break
+       fi
+       rm -rf linux-kernel
+    done
+    [ -d linux-kernel ]
  fi
  cd linux-kernel
  # Make most __CHECKER__ checks ineffective.

Bart.
