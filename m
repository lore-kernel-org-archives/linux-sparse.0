Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2094394474
	for <linux-sparse@vger.kernel.org>; Fri, 16 Jan 2026 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768586301; cv=none; b=fZYGOzTEhAnWsNsM5KzUCGEq8X5maY06VLtbgSrs6nW5PP2ltGNEn0Ziv1DYeS2MekqrfUhpAQq6bqVUUWi94DhQb9ZZx928JPfHLZ9IyE0rqtqJcsLViiCMfOe2V6vnuIyi/alCF+3vpQ36R8E8y7Y4TQW49TsEUm0LcMLNqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768586301; c=relaxed/simple;
	bh=grDuCbkF2FqAKy0g6JQAjhr5qy/ZoND6JtJvXnSl36Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=iwnM4+XiTVkww57KmAEGNeLro78HPNZIBMPbsObQAMOduMW+OhcwGfhF+D+IjzjQ+Vypuc33QpmaDdBTcm52FDYyz/IPiaJtBGHBqJGUQvAb3/Z16WG26aIitj8/H+aVw4qALuUrlnC6WqI8PJIN3NEeI9WDbh0DzmI3XFZCzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=NymYyTOg; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="NymYyTOg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:In-Reply-To:
	References; bh=grDuCbkF2FqAKy0g6JQAjhr5qy/ZoND6JtJvXnSl36Y=; b=NymYyTOgI3IBK7
	KLWreGZeRWF4WWJAFMhA33aXr1IGPJKzLImWtt3jxpRiEoBCldaBhwAWAX3YrVtQP/MnnvWxs3qIO
	QyzVNX1CzirbVaLezAq2hTwYy5u4pFY47+TocazrUVDnwmBvqEPcLrLNpuEyvU6yR/+kPLuTzPIHL
	8qbemXlK8UaBVx3zwF68dzWs1sLEM8yJ7nCHw1DkN+5qChGAY+cWAS+zAxV90e5XzILt0Y9uGwIBj
	EuyPaUznH1R/M2i6OROYeKNLh3/seIrmSaMRV/PMVSNGbqLfEOjLOgQFU0gbnTsyN4ARHejMUaCzh
	Z2k/KRzK+w/+nnM3+t3w==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vgo5K-002Qln-EK; Fri, 16 Jan 2026 17:58:11 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1vgo5L-000000001mv-0lum;
	Fri, 16 Jan 2026 17:58:11 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org,
	sparse@chrisli.org
Subject: add variadic format checking
Date: Fri, 16 Jan 2026 17:58:05 +0000
Message-Id: <20260116175809.6849-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

Third version with a few minor fixes, the only issues seem to be
with the complexities of the linux-kernel which has some printk
fun locally defined.


This series (which was initially sent back in 2020) adds the
ability to deal with __attribute__((format) and checking the
arguments to formatted variadic functions.

I have been considering adding a -Wformat-linux to this as
the kernel now has a number of extra formatting options and
checking the type of these would be useful. An even nicer
extension would be some way of informing the compiler/sparse
of these at compile time (but would need to get agreement on
how to do this with the compilers too)


