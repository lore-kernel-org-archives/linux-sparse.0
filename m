Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0F0129EF7
	for <linux-sparse@vger.kernel.org>; Mon, 18 Dec 2023 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqZbKCmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56044C433CB;
	Mon, 18 Dec 2023 13:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702907833;
	bh=BSTxTcaEnwmT8dt0UDsIrEH/8TEKruSfHYWev9jEHrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqZbKCmd1NkBOXJADnDkl74QZyU5CfR4aI/zPSJrD4EMcRgMF1BPXECoTjJcR9U+Q
	 OWB/ffpw+Eek0bTr8DCNfPthE272QrPqvB8R3MqHGC9W7rM4Ytge1sOVl3k/AGgNCC
	 Ss3dHHJ+Hsv9j7nHBYkYcw3wX1bJosnqn8llbU/40vzZbohKehmh4ac9RYEL2aVGOE
	 Qa8INhCBxB1JDKeBwMmLPb6iJvPDOBM+gPl9Dhe7ZVfSl6AnD7Vcag8XPbUC4vtega
	 pPXzeWqFkbLAlOduKO+lYcnH6p2G9GhBQUBmsRv1pmg5kGxowX2P+YshTlB27fLdAu
	 NXkDGANDIFdcQ==
Date: Mon, 18 Dec 2023 14:57:05 +0100
From: Luc Van Oostenryck <lucvoo@kernel.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: linux-sparse@vger.kernel.org
Subject: Re: [PATCH] xtensa: switch to little endianness
Message-ID: <dyhz44tm67zxgdqau7zv4kwpwfphhw6tb2jyhe3ck2uwglt7pv@rk3ycau5cqb7>
References: <44d1263-fe1-17b6-82d-fd2bbaa55cd@intel.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44d1263-fe1-17b6-82d-fd2bbaa55cd@intel.com>

On Wed, Nov 16, 2022 at 05:55:25PM +0100, Guennadi Liakhovetski wrote:
> Current gcc options only support the little endian mode on Xtensa,
> switch over to it.
> 
> Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Pushed to mainline now. Sorry for this very long delay.
-- Luc
