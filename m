Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5D72D033
	for <linux-sparse@vger.kernel.org>; Fri, 15 Dec 2023 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:28e5:a835:e0b1:5291])
	by baptiste.telenet-ops.be with bizsmtp
	id Nchv2B00529mzEW01chvll; Fri, 15 Dec 2023 13:41:55 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rE7Vr-00C6tf-7I;
	Fri, 15 Dec 2023 13:41:55 +0100
Date: Fri, 15 Dec 2023 13:41:55 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Palmer Dabbelt <palmer@rivosinc.com>
cc: luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Add support fo the zihintpause extension
In-Reply-To: <20220811053356.17375-1-palmer@rivosinc.com>
Message-ID: <b26c790-c192-8b70-9947-cb6ff6a9ac55@linux-m68k.org>
References: <20220811053356.17375-1-palmer@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 10 Aug 2022, Palmer Dabbelt wrote:
> This was recently added to binutils and with any luck will soon be in
> Linux, without it sparse will fail when trying to build new kernels on
> systems with new toolchains.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

As I've just run into

     .../linux$ make C=1

     [...]

     invalid argument to '-march': '_zicsr_zifencei_zihintpause'

and needed to apply this patch before upgrading sparse:

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
