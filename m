Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E69303CB6
	for <linux-sparse@vger.kernel.org>; Wed,  7 Jan 2026 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818482; cv=none; b=kUOAv2TohJa0fxKjEs9flcCVOb08fF9uL6uDFXFfWdtjVKiYUcvcKc0+jD8EE6htAzUbYEX5q0/M4LpQ87B+ZgaELHsZks1AccEC7+3Bwrtzn4DSlnpVGLLuPWfWDwwuK6wAlcAjfmUES44VxrP2WBrl2v9FOt2ADePALA3pSoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818482; c=relaxed/simple;
	bh=FrcJyDIPdPaQxTTNAnsFnyBfOBEM+G55TchdpAmEY5M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cciW/1LsUUIOtrwv8NP8zPgplPQtkG3kJiE9dy8cdlSDG4Eh0/UNNiIoYIL3AXjAM8+VxbGUbIqPMKG2SnpN9jgWmrVcHcwbeNSMGs24qE7dyztEAH+NSXqKhY59g/OOeoRSM9e3dJf+kU2urNSYGrswgj/TNyFK+i3Z16NkccU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKhSRFze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKhSRFze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC56C4CEF1;
	Wed,  7 Jan 2026 20:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767818482;
	bh=FrcJyDIPdPaQxTTNAnsFnyBfOBEM+G55TchdpAmEY5M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=fKhSRFzeBpFbsuImKpHwDlopivZ1tbAWy5Tdiy6HHHgGzAgX/VfRQNrrzXDPdXyzP
	 AH+mSUoyiMjNUXqgi2xoVo1kvtfbuVillKrUmEYegwvZ1+WIAJuPs6kJhSgkx71Srn
	 QXrDBanUJvhcOy5QBf2Ity1ku5K89wTEtY+Q75gVMMeROVfYiFJQVP1jByZ5+BZakH
	 iq3fqYZ6kysEgEv3lCdQYjMwejGPafAMTIQR29nt5D6SEkPE7+bfoMgi5XjA+B1HwT
	 T8+EfoIMgwf5c+Ev6z4upcSCPfyBL8uRRU2Z1VVvUPi1UVzeyfjNoOsQQVET18tykm
	 4bl+umGpLJ5Iw==
Date: Wed, 7 Jan 2026 13:41:18 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
cc: linux-sparse@vger.kernel.org
Subject: Re: [PATCH 1/2] RISC-V: Stop warning about Zabha and Zacas
In-Reply-To: <20260102114449.535597-2-ben.dooks@codethink.co.uk>
Message-ID: <c5021639-ca56-67cc-ccb5-e074e60bb19d@kernel.org>
References: <20260102114449.535597-1-ben.dooks@codethink.co.uk> <20260102114449.535597-2-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 2 Jan 2026, Ben Dooks wrote:

> The zabha (atomic byte and halfword) and zacas (atomic compare/swap)
> are now being used by the kernel, so parse these and stop the warnings
> when running make C=1 on current kernels.
> 
> WARNING: invalid argument to '-march': '_zacas_zabha'
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Thanks Ben.  This saved me some time!

Tested-by: Paul Walmsley <pjw@kernel.org>


- Paul
