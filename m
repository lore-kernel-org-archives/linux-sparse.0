From: Jessica Yu <jeyu@redhat.com>
Subject: [PATCH] arm64: take SHN_LIVEPATCH syms into account when calculating
 plt_max_entries
Date: Tue, 12 Jul 2016 20:11:14 -0400
Message-ID: <20160713001113.GA30925@packer-debian-8-amd64.digitalocean.com>
References: <20160627151500.2247A68D20@newverein.lst.de>
 <20160627151722.B81C968D29@newverein.lst.de>
 <alpine.LNX.2.00.1607111556320.27989@pobox.suse.cz>
 <20160711215807.GA23097@packer-debian-8-amd64.digitalocean.com>
 <alpine.LNX.2.00.1607121141480.16277@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1607121141480.16277@pobox.suse.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miroslav Benes <mbenes@suse.cz>
Cc: linux-arch@vger.kernel.org, Jungseok Lee <jungseoklee85@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Li <sparse@chrisli.org>, Jiri Kosina <jikos@kernel.org>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, takahiro.akashi@linaro.org, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Torsten Duwe <duwe@lst.de>, andrew.wafaa@arm.com, Li Bin <huawei.libin@huawei.com>, live-patching@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-sparse@vger.kernel.org

SHN_LIVEPATCH symbols are technically a subset of SHN_UNDEF/undefined
symbols, except that their addresses are resolved by livepatch at runtime.
Therefore, when calculating the upper-bound for the number of plt entries
to allocate, make sure to take livepatch symbols into account as well.

Signed-off-by: Jessica Yu <jeyu@redhat.com>
---
 arch/arm64/kernel/module-plts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 1ce90d8..1e95dc1 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -122,7 +122,8 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num)
                         * as well, so modules can never grow beyond that limit.
                         */
                        s = syms + ELF64_R_SYM(rela[i].r_info);
-                       if (s->st_shndx != SHN_UNDEF)
+                       if (s->st_shndx != SHN_UNDEF &&
+                           s->st_shndx != SHN_LIVEPATCH)
                                break;

                        /*
-- 
2.5.5
