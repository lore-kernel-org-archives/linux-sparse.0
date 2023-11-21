Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CFF4C71
	for <linux-sparse@vger.kernel.org>; Tue, 21 Nov 2023 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ztjM2uK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51171C433C8;
	Tue, 21 Nov 2023 01:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700529010;
	bh=WydedWHI5hgSzmjYaAgFcEvQrWisnvd0Tah1sl3VwoE=;
	h=Date:From:To:Subject:From;
	b=ztjM2uK9uKXZaxwjFe2HtgdnxrsiWtlRv4bwqCcOmk6WcdZa2OWZuXNsVXwurdIxl
	 4xRMTW6LtWLOiNZ5BnPRE+SwIxGOXfGVEPjzE0c60RnHv8Eoo6Oam8VOXG0rkXUcvd
	 b1JQeAthByavitivpZzSBYzCoRoPdqIcKRpDS330=
Date: Mon, 20 Nov 2023 20:10:09 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-sparse@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231120-glaring-tentacled-bear-c5dbfa@nitro>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to new vger infrastructure. No action is required
on your part and there should be no change in how you interact with this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K
