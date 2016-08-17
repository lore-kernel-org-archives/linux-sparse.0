From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] arm64: take SHN_LIVEPATCH syms into account when
 calculating plt_max_entries
Date: Wed, 17 Aug 2016 11:38:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1608171135360.29236@pobox.suse.cz>
References: <20160627151500.2247A68D20@newverein.lst.de> <20160627151722.B81C968D29@newverein.lst.de> <alpine.LNX.2.00.1607111556320.27989@pobox.suse.cz> <20160711215807.GA23097@packer-debian-8-amd64.digitalocean.com> <alpine.LNX.2.00.1607121141480.16277@pobox.suse.cz>
 <20160713001113.GA30925@packer-debian-8-amd64.digitalocean.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160713001113.GA30925@packer-debian-8-amd64.digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jessica Yu <jeyu@redhat.com>
Cc: Torsten Duwe <duwe@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, takahiro.akashi@linaro.org, Jungseok Lee <jungseoklee85@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Li Bin <huawei.libin@huawei.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Christopher Li <sparse@chrisli.org>, Jiri Kosina <jikos@kernel.org>, andrew.wafaa@arm.com, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, live-patching@vger.kernel.org, linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Tue, 12 Jul 2016, Jessica Yu wrote:

> SHN_LIVEPATCH symbols are technically a subset of SHN_UNDEF/undefined
> symbols, except that their addresses are resolved by livepatch at runtime.
> Therefore, when calculating the upper-bound for the number of plt entries
> to allocate, make sure to take livepatch symbols into account as well.
> 
> Signed-off-by: Jessica Yu <jeyu@redhat.com>

FWIW, I think the patch does what we want, but it's for arm people to 
judge. It might be better to include it to Torsten's patch set.

Miroslav

> ---
> arch/arm64/kernel/module-plts.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index 1ce90d8..1e95dc1 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -122,7 +122,8 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela
> *rela, int num)
>                         * as well, so modules can never grow beyond that
> limit.
>                         */
>                        s = syms + ELF64_R_SYM(rela[i].r_info);
> -                       if (s->st_shndx != SHN_UNDEF)
> +                       if (s->st_shndx != SHN_UNDEF &&
> +                           s->st_shndx != SHN_LIVEPATCH)
>                                break;
> 
>                        /*
> -- 
> 2.5.5
> 
