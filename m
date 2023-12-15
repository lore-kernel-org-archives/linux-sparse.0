Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECBD2C6A3
	for <linux-sparse@vger.kernel.org>; Fri, 15 Dec 2023 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4Ss7yp4HDbz4x1PY
	for <linux-sparse@vger.kernel.org>; Fri, 15 Dec 2023 13:37:22 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:28e5:a835:e0b1:5291])
	by baptiste.telenet-ops.be with bizsmtp
	id NcdE2B00H29mzEW01cdEqC; Fri, 15 Dec 2023 13:37:15 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rE7RK-00C6sX-Nr;
	Fri, 15 Dec 2023 13:37:14 +0100
Date: Fri, 15 Dec 2023 13:37:14 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Conor Dooley <conor.dooley@microchip.com>
cc: Palmer Dabbelt <palmer@rivosinc.com>, luc.vanoostenryck@gmail.com, 
    linux-sparse@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Add support for the zicbom extension
In-Reply-To: <YvYOc9Mk8y1dFvnp@wendy>
Message-ID: <6bc5bd6-afde-3d5f-6780-97d26f58a33@linux-m68k.org>
References: <20220811033138.20676-1-palmer@rivosinc.com> <YvYOc9Mk8y1dFvnp@wendy>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 12 Aug 2022, Conor Dooley wrote:
> On Wed, Aug 10, 2022 at 08:31:38PM -0700, Palmer Dabbelt wrote:
>> This was recently added to binutils and with any luck will soon be in
>> Linux, without it sparse will fail when trying to build new kernels on
>> systems with new toolchains.
>>
>
> In passing while testing the zihintpause one:
> Tested-by: Conor Dooley <conor.dooley@microchip.com>

Likewise:
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
