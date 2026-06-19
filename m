Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901030F523
	for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2026 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852744; cv=none; b=cdP4Kyg3g4QbL2oCZq007n8x3dQRnJXDknKwnIoRtTBzVFk5FJBH7a9NzJiPkwUESAPx0PXLxNWmgogOpo5scENdZ06sTZmK1ukftexGZrZ4kY+DSXoQeokvkItRglS46c80+xIKiuIiztV1MqMYBb5BjZbkTjmSRnhrTYlxsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852744; c=relaxed/simple;
	bh=47/tJizGsBSmKxSDRB8lvB62L83my4OlLOlKVb+N4dI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=SIBLgTONcBt8+qGnGbnD7C6AHzHBF+Pcrm2BQytsa1yrEcvoG5wFIOaaeUvXl37tV68EC4g/pvWFWuxUFB1ifJs7j/hucwUtoyDykaa7uB0mGPSMpIy3sAGs0eKZAcHonmr39Yat3pmC0w7dpruXuZu8orRj8a+4QUfvGjYYojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=fadKFYuK; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="fadKFYuK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:In-Reply-To:
	References; bh=47/tJizGsBSmKxSDRB8lvB62L83my4OlLOlKVb+N4dI=; b=fadKFYuKPRImMJ
	LS7a/a3o9TuZwlHYj+qPc3ekud0E8DpoRPnz+HrdFYOY8R7V3/UxPbk+jt3L0UILMbpGBxDam1yZ9
	8xAey4QWt2kI6y/XqcxE+dM+8Y7LBnfAFUJ7ujitf4uaxVpiuJKm+0XW2IL2z3R2aW2s4Pj7KpcHK
	K9TnMSWH98PvFxGaGCSydBQiEWq00XNyu+5Ewrcg9zsD6ZuLoYlCr2HmqtNzHD0q//ZHlo6cE/l/U
	F7y9PsTz2IYPWMS735i0naHW3yFn3L6CMUeH4j/5Akob42Q+UtpYf9VR6VJwIRjCs4MuEo42ChgPt
	amD80jKpeXqL/jO5eIGA==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1waTIE-00Ap9o-Cv
	for <linux-sparse@vger.kernel.org> ; Fri, 19 Jun 2026 08:05:34 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1waTID-0000000033e-28Xf
	for linux-sparse@vger.kernel.org;
	Fri, 19 Jun 2026 08:05:33 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
Subject: updated variadic printf/scanf checking
Date: Fri, 19 Jun 2026 08:05:28 +0100
Message-Id: <20260619070532.11664-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

I'm reposting this as an RFC as there has been quite a bit of work on
this to get scanf in and to try and simplify the code, fix a few bugs
found when checking the kernel. Depending on the reviews I will post
this for inclusion.

I am also looking at some work to try and make printf and scanf extensible
with the interesting types the kernel adds to printk, either by a new flag
or by some sort of attribute. This is not included in this set.

I think the tests need some more work on scanf, otherwise it seems to work
well with the kernel, and not really found any further issues other than
the odd signed/unsigned and type.


