/*
 * expressionunit.d
 *
 * This module parses expressions.
 *
 */

module parsing.d.expressionunit;

import parsing.parseunit;
import parsing.token;

import parsing.d.tokens;
import parsing.d.nodes;

import parsing.d.assignexprunit;

import io.console;

import djehuty;

class ExpressionUnit : ParseUnit {
	override bool tokenFound(Token current) {
		switch (current.type) {
			default:
				lexer.push(current);
				auto tree = expand!(AssignExprUnit)();
		}
				return false;
	}

protected:
	string cur_string = "";

	static const string _common_error_msg = "";
	static const string[] _common_error_usages = null;
}
