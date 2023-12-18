Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6728129EC8
	for <linux-sparse@vger.kernel.org>; Mon, 18 Dec 2023 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejGSpEyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD02C433CA;
	Mon, 18 Dec 2023 13:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702907987;
	bh=AjGzE/gI19UE0ZfeUYn9FDElYJRgRzb3MkqpLDtXdfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejGSpEyUU1JxCjo2iuizZEi/8tI3Hu6mq61q1YmxyWRz5PO4qxfDOwjDDFrfHPG6Y
	 zUETRhT+nK93RNDm3hloM51+5wzVjVm1+v+ZRTYdmp2l4ewpZwTDFLkaMaYv7q6aUB
	 LkQPeuj1TJ1+O8X4DrrSp5f1CfdTP8NT3BKwjGxEMdEFmFNXfUCq8mzsssX9qs5aqO
	 6o5s8LvWUGNnSseU8ytDreeUPzuxxQPXMhzQVC9KvUlH0sDqW5AJyxUMdh2d0miZhT
	 sB/MsXw4IEYT3CaIuTbtQfuTLvKEvyOCnJ4KtMx+DF0EU3ASqZBnE20r0MlAaOs36d
	 6wfp8171DRpng==
Date: Mon, 18 Dec 2023 14:59:39 +0100
From: Luc Van Oostenryck <lucvoo@kernel.org>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Add support fo the zihintpause extension
Message-ID: <ad37cluochfovzbxbvshv4bzjwitnl5ant2bhewohpip3aq5ld@yfmkog3w5kdd>
References: <20220811053356.17375-1-palmer@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811053356.17375-1-palmer@rivosinc.com>

On Wed, Aug 10, 2022 at 10:33:56PM -0700, Palmer Dabbelt wrote:
> This was recently added to binutils and with any luck will soon be in
> Linux, without it sparse will fail when trying to build new kernels on
> systems with new toolchains.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Pushed to mainline now. Sorry for this very long delay.
-- Luc
