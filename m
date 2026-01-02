Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33060154BF5
	for <linux-sparse@vger.kernel.org>; Fri,  2 Jan 2026 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356813; cv=none; b=Ml1faICK94tkYB3PPponO77InGfh0QvnyFMGVR/i58wTa+1/275Ozm/lU82xETiQNSTVRqks58rCAtFYOoNOg/jxKQWdo9rocXtJnug0AItpAoZTPx7YjWAtbStmPU5comzdbpzut0Iculnv+tfJX77yTsOscVohx+xFIllfug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356813; c=relaxed/simple;
	bh=R32fRZpo+6RDgBXLHgmuQT75IUWyrJ/1Nw373z8RypQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=qXvQxKxzBNQBtY1K94GbKrQbL5Ub74uy1KjqGMUVBKXpWNZbRg7PGzCXTK7AomBFdAyqXP0x2igvDppL54CpQhZE4bI3GofROj7hx8QwPWfFnZGLagBvYz5HKFyy2KqLFBeo9Pdmz6NW7Jw/14rkuvGqYrofg6twXE+1H0K9pyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=Oaex1kq5; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="Oaex1kq5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:In-Reply-To:
	References; bh=R32fRZpo+6RDgBXLHgmuQT75IUWyrJ/1Nw373z8RypQ=; b=Oaex1kq5NV4cUa
	+m873+0fdxReP3Pz4aO8Zm9rHVBshuuLCWRZK9Xq+Geaq3+u2YbmeDj7o6akeY4r/HC1f6+meaRP/
	HFHzgXrZl0obg2qm9hoaIk7JZnMHHF/3tMYTEykgadUmiOidBoJPxUNpYTfnpKAKvKruUmm5vAy7c
	06qju5jWs7/3wdSdFXVPsF5c0b3Dj30axixY6A6kGr7cEIFsZ/xEYgNnJ/0NcetfURGh38INN197Z
	vEgcHbww4VeeNzbIHeoK3FBJlTtNht4l005AIt6gJNJ2CitvBpaFYhFD1W2z8n5lg0xWRx7NwWjKa
	NeFjXdT0qZVR9pwTUMeA==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vbdaM-003fEZ-MW
	for <linux-sparse@vger.kernel.org> ; Fri, 02 Jan 2026 11:44:50 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1vbdaM-00000002FXf-1dZz
	for linux-sparse@vger.kernel.org;
	Fri, 02 Jan 2026 11:44:50 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
Subject: Two updates for RISC-V -march warnings
Date: Fri,  2 Jan 2026 11:44:47 +0000
Message-Id: <20260102114449.535597-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

Updates to remove warnings from latest kernel builds.


