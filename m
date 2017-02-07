From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC/PATCH] arm64: Rename macro arguments to silence sparse
Date: Tue, 7 Feb 2017 12:11:59 -0800
Message-ID: <5f7a5bf1-1285-d9c3-b892-c8f9f8ee6d63@codeaurora.org>
References: <20170207010143.22371-1-sboyd@codeaurora.org>
 <d5bb9d5a-5b02-ffab-d404-bbda532b6c76@codeaurora.org>
 <20170207015047.4ffc3xzrqsuuzo54@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170207015047.4ffc3xzrqsuuzo54@macpro.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Christopher Li <sparse@chrisli.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-sparse@vger.kernel.org

On 02/06/2017 05:50 PM, Luc Van Oostenryck wrote:
> On Mon, Feb 06, 2017 at 05:08:17PM -0800, Stephen Boyd wrote:
>> On 02/06/2017 05:01 PM, Stephen Boyd wrote:
>>> When I compile files with sparse, I get these sorts of warnings:
>>>
>>> arch/arm64/include/asm/lse.h:14:28: warning: Unknown escape 'l'
>>> arch/arm64/include/asm/lse.h:14:37: warning: Unknown escape 'l'
>>> arch/arm64/include/asm/alternative.h:172:28: warning: Unknown escape 'o'
>>>
>>> This is because sparse is trying to tokenize these files and sees
>>> a line like this:
>>>
>>>  alternative_insn "\llsc", "\lse", ARM64_HAS_LSE_ATOMICS
>>>
>>> It gets past alternative_insn part and then sees the start of a
>>> string with the double quote character. So sparse starts to parse
>>> the string (eat_string() in the sparse code) but the string has
>>> an escape character '\' in it. Sparse sees the escape character,
>>> so it checks to see if it's an escape sequence, but '\l' isn't.
>>> This causes sparse to spit out this warning of an unknown escape
>>> sequence 'l'.
>>>
>>> In reality, sparse isn't going to use these macros anyway because
>>> this whole thing is inside an __ASSEMBLER__ ifdef.
> Yes, annoying. Conversion of escaped characters is supposed to be
> done just after preprocessing. It's definitively a bug.

Ok. Thanks for the fixes to sparse. My hack patch can be safely ignored.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
