Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21EA3F0746
	for <linux-sparse@vger.kernel.org>; Wed, 17 Jun 2026 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704689; cv=none; b=O63QFi39AMhdwQjHJ+UCxh4dd4DtZ4Xej/36hQA6lJHDcaqVptGO7LbFeXmZiY6QXrLytVxJ+PXCga3pJui2yICIZPbwJYpcvK///8Im/Ehj3ywdQ6IBgEpZWiahcb4U0z1g98uo2hhiTNs9zU/TEUhHt7Aicbp448fauVtt2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704689; c=relaxed/simple;
	bh=8tJ/5r6hJ4O0ESaDXYaa4ATLqtpOg11ccO/Opdm7qLE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GUqlrDiCNhuZ/5p1+s+liuMnUPXEl8/aO2Pg51GCF90dfH+2lnE2bEOPOO4dEvreQy//9vA22z0laX/5MZ/eJ8doP5Y/tc+1yWEeSIS4qgWodQaM5G74hMBOF1F8Fju5MUUIGv3RA3ze+hraFuvA0Jq5oD55wU43JQCz0Bizhss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=eYeQmvV/; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="eYeQmvV/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:In-Reply-To:
	References; bh=4WyB4x8PhBE7H+8m0zVj35zXWd5Cr75ZPPZdZvLzahU=; b=eYeQmvV/HkKTMo
	ABFrxETa4Muz0ic9NsSCZ05rQB1M274928/CdgpNznZsk6k0LEcZcx492UpXptwhzOCr0AW+QYMK3
	vnR0DZZKx/M4XdQn9XrTT8DfmUurDpVQVCY1IMZhaKDrWA01qJmn684QZ8WTkYAFsehhMja081X1K
	xyEL5onsKAqMaDpxwcZnocT8UCBMuv3GQxtjbuYxN37GZRyjS+LyL4c5pRGd+I+q+v51MKUj6PH3/
	+tRE6dMeCaghzGdyzaqsD4lvLrXXHzrwLrBESI2PL6diAbdx2a94PBVgh4Di04mgPnLVHOeotKf+R
	ISstvFQjQq7GXr67Gvvg==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wZqmL-00DZsi-Sx
	for <linux-sparse@vger.kernel.org> ; Wed, 17 Jun 2026 14:58:05 +0100
Message-ID: <ebcf4663-4c95-4b51-887c-d0c99b8b80ea@codethink.co.uk>
Date: Wed, 17 Jun 2026 14:58:05 +0100
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-sparse@vger.kernel.org
From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: segfault with latest arm64 linux kernel build
Organization: Codethink Limited.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

I'm getting a fault running the sparse check on current kernel.

   CC [M]  drivers/gpu/drm/msm/msm_gem.o
   CHECK   /home/ben/linux/drivers/gpu/drm/msm/msm_gem.c
Segmentation fault

The base of my tree is, however I have a pile of fixes
on this:

commit 4b99990cdf9560e8a071640baf19f312e6ae02f4 (origin/master, origin/HEAD)
Merge: 9c87e61e3c57 52d4ab1ca790
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jun 17 10:21:00 2026 +0100

     Merge tag 'drm-next-2026-06-17' of 
https://gitlab.freedesktop.org/drm/kernel


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

