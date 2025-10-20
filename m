Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230751EEE6
	for <linux-sparse@vger.kernel.org>; Mon, 20 Oct 2025 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974766; cv=none; b=WOlRRygxVc60zSb9SovPB44LKPp/WRjemQajGQnXgQ00O0J/G6/LPTwOChm9Oe9mfkryGZQV1Ze32d3vIGU0atjdfG0mwEEzMf9ZV6c9uCrVkF4mEnjUYdWbhQr8iLE10yp4tdIAfK75ngeJWrSvZ1Z5gMB41NpAmbCZSF2DCJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974766; c=relaxed/simple;
	bh=c/FHZy4o33NpWjzCMP8Aa7X6b0jmvB7lmOtrBi8A1zA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=BPFEuoUYwJfrJziMTL8KjFkb/jAx3AjKRehs+PVYBOn7cLybI6rRq7Zb+66D1lredSZhGiOIdZJE4eOZkAhfo7FhW72n9V2QOPTGkKAW22Fnm8Qbo9Dn4xk2mVtrZ5dKq36Scp9wH0LqdUUVqKKYoPuWWIo/zkXVH4L5m5MFfTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=ADbs0/v5; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="ADbs0/v5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:In-Reply-To:
	References; bh=c/FHZy4o33NpWjzCMP8Aa7X6b0jmvB7lmOtrBi8A1zA=; b=ADbs0/v5mcy8K3
	6z1xN/JdWYOuQo8uhyCe/W2blYy55RBIPVVmAHlSbJ7l2KkyBB40OZ0L4pHSZW+mYLAYXA8//MCBZ
	udqwHyHch+VGuvi+A0LIfTcNzaz0FGx8mws7fsLGd3dX/LZNyHqc29O9JApq9o7VwZJH4mvJi7wmH
	0ROuGppm2Cl9CVF+hmoVfNaXPsoV9BM2KszRN5kmv9XHz8R1SJJQ074lhYoQAr0B+kUrLj8QBi1uO
	0ghoncVZFFY0yaR/Jglm4VHJion32x3PIIf8PH+ge4WjexVJb7u1PfanL6NA2WQmwZwHsysSE2JeH
	RfU/hkC1K+g3dGOqQHvA==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vAryh-00H70M-Sp; Mon, 20 Oct 2025 16:39:20 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
	(envelope-from <ben@rainbowdash>)
	id 1vAryh-00000003PJ1-18Dx;
	Mon, 20 Oct 2025 16:39:19 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>
Subject: Add printf/scanf -Wformat checking
Date: Mon, 20 Oct 2025 16:39:14 +0100
Message-Id: <20251020153918.812235-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

[re-send as outgoing mail setup had a DKIM issue pointed out
by Linus]

This series (which was initially sent back in 2020) adds the
ability to deal with __attribute__((format) and checking the
arguments to formatted variadic functions.

I have been considering adding a -Wformat-linux to this as
the kernel now has a number of extra formatting options and
checking the type of these would be useful. An even nicer
extension would be some way of informing the compiler/sparse
of these at compile time (but would need to get agreement on
how to do this with the compilers too)

Another quesiton is to leave this as 4 patches or merge down?


