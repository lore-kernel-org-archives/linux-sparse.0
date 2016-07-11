From: Jessica Yu <jeyu@redhat.com>
Subject: Re: arm64: implement live patching
Date: Mon, 11 Jul 2016 17:58:07 -0400
Message-ID: <20160711215807.GA23097@packer-debian-8-amd64.digitalocean.com>
References: <20160627151500.2247A68D20@newverein.lst.de>
 <20160627151722.B81C968D29@newverein.lst.de>
 <alpine.LNX.2.00.1607111556320.27989@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1607111556320.27989@pobox.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
To: Miroslav Benes <mbenes@suse.cz>
Cc: Torsten Duwe <duwe@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, takahiro.akashi@linaro.org, Jungseok Lee <jungseoklee85@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Li Bin <huawei.libin@huawei.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Christopher Li <sparse@chrisli.org>, Jiri Kosina <jikos@kernel.org>, andrew.wafaa@arm.com, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, live-patching@vger.kernel.org, linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

+++ Miroslav Benes [11/07/16 16:03 +0200]:
>On Mon, 27 Jun 2016, Torsten Duwe wrote:
>
>> diff --git a/arch/arm64/include/asm/livepatch.h b/arch/arm64/include/asm/livepatch.h
>> new file mode 100644
>> index 0000000..6b9a3d1
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/livepatch.h
>> @@ -0,0 +1,37 @@
>> +/*
>> + * livepatch.h - arm64-specific Kernel Live Patching Core
>> + *
>> + * Copyright (C) 2016 SUSE
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version 2
>> + * of the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +#ifndef _ASM_ARM64_LIVEPATCH_H
>> +#define _ASM_ARM64_LIVEPATCH_H
>> +
>> +#include <linux/module.h>
>> +#include <linux/ftrace.h>
>> +
>> +#ifdef CONFIG_LIVEPATCH
>
>A nit but we removed such guards in the other header files.
>
>> +static inline int klp_check_compiler_support(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
>> +{
>> +	regs->pc = ip;
>> +}
>> +#endif /* CONFIG_LIVEPATCH */
>
>I also checked mod_arch_specific structure because of the way we deal
>with relocations. It is defined only if CONFIG_ARM64_MODULE_PLTS is
>enabled and there is a pointer to 'struct elf64_shdr' called plt. It is
>used indirectly in apply_relocate_add() so we need it to stay. However it
>points to an existing Elf section and SHF_ALLOC is added to its sh_flags
>in module_frob_arch_sections() (arch/arm64/kernel/module-plts.c).
>Therefore we should be ok.
>
>Jessica, could you check it as well, please?

That sounds right, the plt will remain in module core memory, so we
are fine there.

However I think the plt->sh_size calculation will be incorrect for
livepatch modules. In calculating mod->arch.plt_max_entries (see:
module-plts.c), count_plts() is called for every rela section.
For livepatch modules, this means count_plts() will also be called for
our .klp.rela sections, which is correct behavior. However,
count_plts() only considers relas referring to SHN_UNDEF symbols, and
since every rela in a klp rela section refers to a SHN_LIVEPATCH
symbol, these are all ignored. So count_plts() may return an incorrect
value for a klp rela section.

Miroslav, can you confirm the issue? I think the fix would be easy
though; we can just add an additional check for SHN_LIVEPATCH in
count_plts(). 

Jessica
