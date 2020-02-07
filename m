From: Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf] bpf: Improve bucket_log calculation logic
Date: Fri, 7 Feb 2020 23:04:50 +0100
Message-ID: <87b3934a-094f-28c1-c5ce-3792c1fa0356@iogearbox.net>
References: <20200207081810.3918919-1-kafai@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200207081810.3918919-1-kafai@fb.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, David Miller <davem@davemloft.net>, kernel-team@fb.com, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
List-Id: linux-sparse@vger.kernel.org

On 2/7/20 9:18 AM, Martin KaFai Lau wrote:
> It was reported that the max_t, ilog2, and roundup_pow_of_two macros have
> exponential effects on the number of states in the sparse checker.
> 
> This patch breaks them up by calculating the "nbuckets" first so
> that the "bucket_log" only needs to take ilog2().
> 
> Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Applied (& improved changelog to clarify it's not just sparse), thanks!
